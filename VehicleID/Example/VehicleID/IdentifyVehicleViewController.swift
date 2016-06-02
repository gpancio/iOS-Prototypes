//
//  IdentifyVehicleViewController.swift
//  TestAudaToolkitPod
//

import UIKit
import GPUIKit
import VehicleID
import EdmundsAPI
import MBProgressHUD

class IdentifyVehicleViewController: ATViewController, ScanVINViewControllerDelegate, VINDecoderDelegate {
    
    var vehicle: Vehicle? {
        didSet {
            if vehicle != nil {
                addNextButton()
            } else {
                nextButton?.hidden = true
            }
        }
    }
    
    var progressHud: MBProgressHUD?
    
    private var vin: String?
    
    func addNextButton() {
        guard vehicle != nil else { return }
        
        if !vehicle!.availablePackages.isEmpty {
            nextButton?.setTitle("Next: Select a Package", forState: .Normal)
        } else if !vehicle!.options.isEmpty {
            nextButton?.setTitle("Next: Select Options", forState: .Normal)
        }
        
        nextButton?.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton?.hidden = true
        if vehicle != nil {
            nextButton?.hidden = false
        }
    }
    
    // MARK: - ScanVINViewControllerDelegate
    func vinScanned(vin: String) {
        self.vin = vin
        self.vehicle = nil
        startVINDecode(vin)
    }
    
    // MARK: VIN Decoding
    func startVINDecode(vin: String) {
        progressHud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHud?.labelText = "Decoding VIN..."
        
        var decoder = createVINDecoder()
        decoder.vinDelegate = self
        decoder.decodeVIN(vin)
    }
    
    func vinDecodeSuccess(vehicle: Vehicle) {
        dispatch_async(dispatch_get_main_queue()) {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        showConfirmDialog(vehicle)
    }
    
    func vinDecodeFailed(reason: VINDecodeFailureReason) {
        dispatch_async(dispatch_get_main_queue()) {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        switch reason {
        case .InvalidVIN:
            showErrorAlert("Failed to decode VIN: invalid VIN")
            vehicle = nil
            break
        case .ServiceNotAvailable:
            showErrorAlert("Failed to decode VIN: service unavailable")
            break
        }
    }

    func showConfirmDialog(vehicle: Vehicle) {
        let alertController = UIAlertController(title: vehicle.yearMakeModel, message: "Is this your vehicle?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let nopeAction = UIAlertAction(title: "Nope!", style: .Cancel) { (action) in
            self.vehicle = nil
        }
        alertController.addAction(nopeAction)
        
        let yupAction = UIAlertAction(title: "Yes!", style: .Default) { (action) in
            self.vehicle = vehicle
        }
        alertController.addAction(yupAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class OfflineDataProvider: DataProvider {
        var validSet: [String]
        
        init(validSet: [String]) {
            self.validSet = validSet
        }
        
        func fetchData(dataMap: DataMap, completion: [String] -> Void, error: (String -> Void)? ) {
            completion(validSet)
        }
    }
    
    func createDataMap() -> DataMap {
        let dataMap = DataMap()
        
        var makeDataProvider: DataProvider
        var modelDataProvider: DataProvider
        var styleDataProvider: DataProvider
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.boolForKey("offline") {
            makeDataProvider = OfflineDataProvider(validSet: ["Acura", "Audi", "BMW", "Buick", "Cadillac", "Honda", "Toyota"])
            modelDataProvider = OfflineDataProvider(validSet: ["Civic", "CRV", "Odyssey", "Pilot"])
            styleDataProvider = OfflineDataProvider(validSet: ["EX", "GX", "LX"])
        } else {
            makeDataProvider = VehicleMakesDataProvider()
            modelDataProvider = VehicleModelsDataProvider()
            styleDataProvider = VehicleStylesDataProvider()
        }
        
        let years = (1970...(NSCalendar.getCurrentYear()+1)).map() { return "\($0)"}
        
        let yearDataSet = DataSet(validSet: years.reverse())
        dataMap[Key.Year] = yearDataSet
        
        let makeDataSet = DataSet(dataProvider: makeDataProvider)
        makeDataSet.observe(yearDataSet)
        dataMap[Key.Make] = makeDataSet
        
        let modelDataSet = DataSet(dataProvider: modelDataProvider)
        modelDataSet.observe(makeDataSet)
        dataMap[Key.Model] = modelDataSet
        
        let styleDataSet = DataSet(dataProvider: styleDataProvider)
        styleDataSet.observe(modelDataSet)
        dataMap[Key.Style] = styleDataSet
        
        return dataMap
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scanVIN" {
            if let vc = segue.destinationViewController as? ScanVINViewController {
                vc.delegate = self
            }
        } else if segue.identifier == "selectVehicleEmbed" {
            if let vc = segue.destinationViewController as? IdentifyVehicleTableViewController {
                vc.rootViewController = self
                vc.dataMap = createDataMap()
            }
        }
    }
}

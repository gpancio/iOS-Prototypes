//
//  IdentifyVehicleMainViewController.swift
//  VehicleID
//

import UIKit
import GPUIKit
import MBProgressHUD
import EdmundsAPI

public protocol IdentifyVehicleMainViewControllerDelegate: class {
    func vehicleIdentified(vehicle: Vehicle)
}

public class IdentifyVehicleMainViewController: ATViewController, SelectVehicleDelegate,
    ScanVINViewControllerDelegate, DecodeVINDelegate {
    
    public weak var delegate: IdentifyVehicleMainViewControllerDelegate?
    
    public var vehicle: Vehicle? {
        didSet { updateUI() }
    }
    var progressHud: MBProgressHUD?

    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    private func updateUI() {
        if let veh = vehicle {
            vinLabel?.text = veh.vin
            yearLabel?.text = veh.year.stringValue
            makeLabel?.text = veh.make
            modelLabel?.text = veh.model
            styleLabel?.text = veh.style?.style ?? ""
        } else {
            vinLabel?.text = ""
            yearLabel?.text = ""
            makeLabel?.text = ""
            modelLabel?.text = ""
            styleLabel?.text = ""
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func startVINDecode(vin: String) {
        progressHud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progressHud?.labelText = "Decoding VIN..."
        
        let decoder = DecodeVIN()
        decoder.delegate = self
        decoder.decodeVIN(vin)
    }
    
    // MARK: - SelectVehicleDelegate
    public func vehicleSelected(vehicle: Vehicle) {
        self.vehicle = vehicle
        delegate?.vehicleIdentified(vehicle)
    }
    
    // MARK: - ScanVINViewControllerDelegate
    public func vinScanned(vin: String) {
        print("Scanned VIN: \(vin)")
        vinLabel.text = vin
        
        startVINDecode(vin)
    }
    
    // MARK: - DecodeVINDelegate
    public func vinDecoded(vehicle: Vehicle) {
        self.vehicle = vehicle
        delegate?.vehicleIdentified(vehicle)
        
        dispatch_async(dispatch_get_main_queue()) {
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    public func vinDecodeFailed(reason: VINDecodeFailureReason) {
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
    
    public func invalidInput() {
        // TODO
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectVehicle" {
            if let vc = segue.destinationViewController as? SelectVehicleViewController {
                vc.delegate = self
                vc.vehicle = vehicle
            }
        } else if segue.identifier == "scanVIN" {
            if let vc = segue.destinationViewController as? ScanVINViewController {
                vc.delegate = self
            }
        }
    }

}



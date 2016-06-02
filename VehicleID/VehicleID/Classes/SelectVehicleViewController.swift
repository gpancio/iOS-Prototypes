//
//  SelectVehicleViewController.swift
//  VehicleID
//

import UIKit
import GPUIKit
import EdmundsAPI

public protocol SelectVehicleDelegate: class {
    func vehicleSelected(vehicle: Vehicle)
}

public class SelectVehicleViewController: ATViewController, UIPickerViewDataSource, UIPickerViewDelegate,
    GetMakesDelegate, GetModelsDelegate, GetStylesDelegate
{
    
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var makePickerView: UIPickerView!
    @IBOutlet weak var modelPickerView: UIPickerView!
    @IBOutlet weak var stylePickerView: UIPickerView!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func cancel(sender: AnyObject) {
        goBack()
    }
    
    @IBAction func done(sender: AnyObject) {
        if inputIsComplete() {
            let newVehicle = Vehicle(year: selectedYear!.value, make: selectedMake!.value, model: selectedModel!.value)
            if let style = selectedStyle {
                newVehicle.style = style.value
            }
            
            if newVehicle == self.vehicle {
                newVehicle.vin = self.vehicle?.vin
            }
            
            delegate?.vehicleSelected(newVehicle)
        }
        
        goBack()
    }
    
    private var years = [String]()
    
    private var makes: [String]? {
        didSet {
            if makes == nil || makes!.isEmpty {
                selectedMake = nil
                models = nil
            }
            makePickerView.reloadAllComponents()
        }
    }
    
    private var models: [String]? {
        didSet {
            if models == nil || models!.isEmpty {
                selectedModel = nil
                styles = nil
            }
            modelPickerView.reloadAllComponents()
        }
    }
    
    private var styles: [VehicleStyle]? {
        didSet {
            if styles == nil || styles!.isEmpty {
                selectedStyle = nil
            }
            stylePickerView.reloadAllComponents()
        }
    }
    
    var vehicle: Vehicle?
    public weak var delegate: SelectVehicleDelegate?
    
    private let getMakesSvc = GetMakes()
    private let getModelsSvc = GetModels()
    private let getStylesSvc = GetStyles()
    
    // MARK: - Selections
    var selectedYear: (value: NSNumber, validated: Bool)? {
        didSet {
            yearLabel.text = "\(selectedYear!.value)"
            updateDoneButtonEnabled()
        }
    }
    
    var selectedMake: (value: String, validated: Bool)? {
        didSet {
            if selectedMake == nil {
                models = nil
            }
            makeLabel.text = selectedMake?.value
            updateDoneButtonEnabled()
        }
    }
    
    var selectedModel: (value: String, validated: Bool)? {
        didSet {
            if selectedModel == nil {
                styles = nil
            }
            modelLabel.text = selectedModel?.value
            updateDoneButtonEnabled()
        }
    }
    
    var selectedStyle: (value: VehicleStyle, validated: Bool)? {
        didSet {
            styleLabel.text = selectedStyle?.value.style
            updateDoneButtonEnabled()
        }
    }
    
    private func populateMakes(year: NSNumber) {
        getMakesSvc.makeRequest(year)
        
        if let make = selectedMake?.value {
            selectedMake = (make, false)
        }
    }
    
    private func populateModels(year: NSNumber, make: String) {
        getModelsSvc.makeRequest(year, make: make)
        
        if let model = selectedModel?.value {
            selectedModel = (model, false)
        }
    }
    
    private func populateStyles(year: NSNumber, make: String, model: String) {
        getStylesSvc.makeRequest(year, make: make, model: model)
        
        if let style = selectedStyle?.value {
            selectedStyle = (style, false)
        }
    }
    
    private func inputIsComplete() -> Bool {
        return selectedYear != nil && selectedMake != nil && selectedModel != nil
    }
    
    private func inputIsValid() -> Bool {
        return inputIsComplete() && selectedYear!.validated && selectedMake!.validated && selectedModel!.validated && (selectedStyle?.validated ?? true)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None

        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        
        makePickerView.delegate = self
        makePickerView.dataSource = self
        
        modelPickerView.delegate = self
        modelPickerView.dataSource = self
        
        stylePickerView.delegate = self
        stylePickerView.dataSource = self
        
        getMakesSvc.delegate = self
        getModelsSvc.delegate = self
        getStylesSvc.delegate = self
        
        years = (1970...(NSCalendar.getCurrentYear()+1)).map() { return "\($0)"}
        
        if let preselectedVehicle = vehicle {
            self.selectedYear = (preselectedVehicle.year, true)
            self.selectedMake = (preselectedVehicle.make, true)
            self.selectedModel = (preselectedVehicle.model, true)
            if let preselectedStyle = preselectedVehicle.style {
                self.selectedStyle = (preselectedStyle, true)
            }
            
            yearPickerView.selectRow(preselectedVehicle.year as Int - 1970, inComponent: 0, animated: true)
            populateMakes(preselectedVehicle.year)
            populateModels(selectedYear!.value, make: selectedMake!.value)
            populateStyles(selectedYear!.value, make: selectedMake!.value, model: selectedModel!.value)
        } else {
            yearPickerView.selectRow(years.count-2, inComponent: 0, animated: true)
        }
        
        updateDoneButtonEnabled()
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView === yearPickerView {
            return 1
        } else if pickerView === makePickerView {
            return 1
        } else if pickerView === modelPickerView {
            return 1
        } else if pickerView === stylePickerView {
            return 1
        }
        
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === yearPickerView {
            return years.count
        } else if pickerView === makePickerView {
            return makes?.count ?? 0
        } else if pickerView === modelPickerView {
            return models?.count ?? 0
        } else if pickerView === stylePickerView {
            return styles?.count ?? 0
        }
        
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var titleString = ""
        if pickerView === yearPickerView {
            titleString = years[row]
        } else if pickerView === makePickerView {
            titleString = makes?[row] ?? ""
        } else if pickerView === modelPickerView {
            titleString = models?[row] ?? ""
        } else if pickerView === stylePickerView {
            titleString = styles?[row].style ?? ""
        }
        
        let title = NSAttributedString(string: titleString, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 18.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()])

        pickerLabel.attributedText = title
        return pickerLabel
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doneButton?.enabled = false
        
        if pickerView === yearPickerView {
            if row >= years.count { return  }
            selectedYear = (Int(years[row])!, true)
            populateMakes(selectedYear!.value)
        } else if pickerView === makePickerView {
            if let makes = self.makes {
                if row >= makes.count { return  }
                selectedMake = (makes[row], true)
                populateModels(selectedYear!.value, make: selectedMake!.value)
            }
        } else if pickerView === modelPickerView {
            if let models = self.models {
                if row >= models.count { return }
                selectedModel = (models[row], true)
                populateStyles(selectedYear!.value, make: selectedMake!.value, model: selectedModel!.value)
            }
        } else if pickerView === stylePickerView {
            if let styles = self.styles {
                if row >= styles.count { return }
                selectedStyle = (styles[row], true)
            }
        }
        
        updateDoneButtonEnabled()
    }
    
    // MARK: - Get Makes
    public func onSuccess(makes: [String]) {
        self.makes = makes
        
        // Did we have a selected make already?
        if let make = selectedMake?.value {
            // Yes. Is that make still valid, ie is it in the new set of makes?
            if let index = makes.indexOf(make) {
                // It is still valid. Select it and set it as validated.
                makePickerView.selectRow(index, inComponent: 0, animated: true)
                selectedMake!.validated = true
                pickerView(makePickerView, didSelectRow: index, inComponent: 0)
            } else {
                makePickerView.selectRow(0, inComponent: 0, animated: true)
                selectedMake = nil
            }
        }
    }
    
    public func onFail(reason: String) {
        showErrorAlert("Failed to retrieve vehicle makes.")
        makes = nil
    }
    
    // MARK: - Get Models
    public func gotModels(models: [String]) {
        self.models = models
        
        if let model = selectedModel?.value {
            if let index = models.indexOf(model) {
                modelPickerView.selectRow(index, inComponent: 0, animated: true)
                selectedModel!.validated = true
                pickerView(modelPickerView, didSelectRow: index, inComponent: 0)
            } else {
                modelPickerView.selectRow(0, inComponent: 0, animated: true)
                selectedModel = nil
            }
        }
    }
    
    public func getModelsFailed(reason: String) {
        showErrorAlert("Failed to retrieve vehicle models.")
        models = nil
    }
    
    // MARK: - GetStylesDelegate
    public func gotStyles(styles: [VehicleStyle]) {
        self.styles = styles
        
        if let style = selectedStyle?.value {
            if let index = styles.indexOf(style) {
                stylePickerView.selectRow(index, inComponent: 0, animated: true)
                selectedStyle!.validated = true
            } else {
                selectedStyle = nil
            }
        }
    }
    
    public func getStylesFailed(reason: String) {
        showErrorAlert("Failed to retrieve style info")
        styles = nil
    }
    
    // MARK: - Utilities
    
    private func updateDoneButtonEnabled() {
        doneButton?.enabled = inputIsValid()
    }

}

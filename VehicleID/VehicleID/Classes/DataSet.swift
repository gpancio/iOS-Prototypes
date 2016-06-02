//
//  DataSet.swift
//  VehicleID
//

import Foundation

public protocol DataSetObserver: class {
    func selectedValueChanged()
}

/**
 A DataSet contains a set of data (strings) along with the value that is currently selected (or nil, if no value 
 has been selected.
 
 Other objects can register to be notified of changes to the selected value.
 */
public class DataSet {
    
    // DataMap is basically just needed to pass to the dataProvider.
    public var dataMap: DataMap?
    
    // Perhaps inject this in populate() instead.
    var dataProvider: DataProvider?
    var completion: (()->())?
    
    var observers = [DataSetObserver]()
    
    var validSet = [String]() {
        didSet {
            if let selected = selectedValue {
                if !validSet.contains(selected) {
                    selectedValue = nil
                }
            }
        }
    }
    
    public var selectedValue: String? {
        didSet {
            let _ = observers.map() { $0.selectedValueChanged() }
        }
    }
    
    public init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    public init(validSet: [String]) {
        self.validSet = validSet
    }
    
    deinit {
        observers.removeAll()
    }
    
    public func observe(dataSetToObserve: DataSet) {
        dataSetToObserve.observers.append(self)
    }
    
    public func selectIndex(index: Int) {
        guard index < validSet.count && index >= 0 else {
            return
        }
        
        let value = validSet[index]
        // See if the selected value changed. If it didn't change, don't updated selectedValue in order
        // to prevent observer notification.
        if let currentSelectedValue = selectedValue {
            if value != currentSelectedValue {
                selectedValue = value
            }
        } else {
            selectedValue = value
        }
    }
    
    public func deselectValue() {
        selectedValue = nil
    }
    
    public func populate(completion: (() -> ())?) {
        if dataProvider != nil {
            self.completion = completion
            dataProvider!.fetchData(dataMap!, completion: { data in self.dataReceived(data) },
                                    error: { reason in self.errorReceived(reason) } )
        } 
    }
    
    func dataReceived(data: [String]) {
        validSet = data
        completion?()
        completion = nil
    }
    
    func errorReceived(reason: String) {
        completion = nil
    }
}

extension DataSet: DataSetObserver {
    public func selectedValueChanged() {
        validSet.removeAll()
    }
}

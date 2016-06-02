//
//  VehicleDataSet.swift
//  VehicleID
//

import Foundation
import EdmundsAPI

public struct Key {
    public static let Year = "year"
    public static let Make = "make"
    public static let Model = "model"
    public static let Style = "style"
}

public protocol DataProvider: class {
    func fetchData(dataMap: DataMap, completion: [String] -> Void, error: (String -> Void)?)
}

public class VehicleDataProviderBase {
    public var completion: ([String] -> Void)?
    public var error: (String -> Void)?
}

public class VehicleMakesDataProvider: VehicleDataProviderBase, DataProvider, GetMakesDelegate {
    let svc = GetMakes()
    
    public override init() {}
    
    public func fetchData(dataMap: DataMap, completion: [String] -> Void, error: (String -> Void)? ) {
        guard let year = dataMap[Key.Year]?.selectedValue else {
            return
        }
        
        svc.delegate = self
        self.completion = completion
        self.error = error
        svc.getMakes(Int(year)!)
    }
    
    public func onSuccess(makes: [String]) {
        completion?(makes)
    }
    
    public func onFail() {
        error?("Failure")
    }
}

public class VehicleModelsDataProvider: VehicleDataProviderBase, DataProvider, GetModelsDelegate {
    let svc = GetModels()
    
    public override init() {}
    
    public func fetchData(dataMap: DataMap, completion: [String] -> Void, error: (String -> Void)? ) {
        guard let year = dataMap[Key.Year]?.selectedValue, make = dataMap[Key.Make]?.selectedValue else {
            return
        }
        
        svc.delegate = self
        self.completion = completion
        self.error = error
        svc.getModels(Int(year)!, make: make)
    }
    
    public func onSuccess(models: [String]) {
        completion?(models)
    }
    
    public func onFail() {
        error?("Failure")
    }
}

public class VehicleStylesDataProvider: VehicleDataProviderBase, DataProvider, GetStylesDelegate {
    let svc = GetStyles()
    
    public override init() {}
    
    public func fetchData(dataMap: DataMap, completion: [String] -> Void, error: (String -> Void)? ) {
        guard let year = dataMap[Key.Year]?.selectedValue, make = dataMap[Key.Make]?.selectedValue,
                  model = dataMap[Key.Model]?.selectedValue else {
            return
        }
        
        svc.delegate = self
        self.completion = completion
        self.error = error
        svc.getStyles(Int(year)!, make: make, model: model)
    }
    
    public func onSuccess(styles: [VehicleStyle]) {
        completion?(styles.map() { return $0.style })
    }
    
    public func onFail(reason: String) {
        error?("Failure")
    }
}


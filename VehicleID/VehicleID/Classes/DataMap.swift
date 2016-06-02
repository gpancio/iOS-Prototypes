//
//  DataMap.swift
//  VehicleID
//

import Foundation

public protocol DataSetProvider {
    func dataSet(forKey key: String) -> DataSet?
}

/**
 Basically just wraps a dictionary which maps a String key to a DataSet.
 Adds the notion of "selected values". DataSets can have selected values,
 so the DataMap can retrieve all selected values for all keys, or deselect all values.
 */
public class DataMap {
    public var dataMap = [String:DataSet]()
    
    public subscript(key: String) -> DataSet? {
        get {
            return dataMap[key]
        }
        set(newValue) {
            dataMap[key] = newValue
            newValue?.dataMap = self
        }
    }
    
    public init() {}
    
    public func deselectAll() {
        for value in dataMap.values {
            value.selectedValue = nil
        }
    }
    
    public var selectedValues: [String:String] {
        get {
            var values = [String:String]()
            for key in dataMap.keys {
                if let value = self[key]?.selectedValue {
                    values[key] = value
                }
            }
        
            return values
        }
    }
}

extension DataMap: DataSetProvider {
    public func dataSet(forKey key: String) -> DataSet? {
        return self.dataMap[key]
    }
}

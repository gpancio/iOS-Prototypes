//
//  Vehicle.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

public class Vehicle: Mappable {
    public var vin: String?
    public var year: Int?
    public var make: String?
    public var model: String?
    public var style: VehicleStyle?
    public var options: [VehicleOptionSet]?
    public var colors: [VehicleColorSet]?
    public var numOfDoors: String?
    public var transmission: VehicleTransmission?
    
    public init() {
        
    }
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        class YearData: Mappable {
            var year: Int?
            var styles: VehicleOptionSet?
            
            required init?(_ map: Map) {}
            func mapping(map: Map) {
                year <- map["year"]
                styles <- map["styles"]
            }
        }
        
        var yearData: [YearData]?
        yearData <- map["years"]
        
        year = yearData![0].year!
        make <- map["make.name"]
        model <- map["model.name"]
        options <- map["options"]
        colors <- map["colors"]
        numOfDoors <- map["numOfDoors"]
        transmission <- map["transmission"]
    }
    
    public var yearMakeModel: String {
        get {
            if let year = self.year, make = self.make, model = self.model {
                return "\(year) \(make) \(model)"
            }
            return "N/A"
        }
    }
}
//
//  VehicleOption.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Represents a set of vehicle options.
 */
public class VehicleOptionSet: Mappable {
    public var category: String?
    public var options: [VehicleOption]?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        category <- map["category"]
        options <- map["options"]
    }
}
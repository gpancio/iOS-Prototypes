//
//  VehicleColorSet.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Represents a set of colors a vehicle can have.
 */

public class VehicleColorSet: Mappable {
    /**
     The category of the color: "Interior", "Exterior", etc.
     */
    public var category: String?
    
    /**
     The color options within the category.
     */
    public var options: [VehicleColor]? {
        didSet {
            options?.sortInPlace { $0.primaryColorChip < $1.primaryColorChip }
        }
    }
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        category <- map["category"]
        options <- map["options"]
    }

}
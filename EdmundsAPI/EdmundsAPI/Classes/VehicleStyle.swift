//
//  VehicleStyle.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Describes a style of vehicle.
 */
public class VehicleStyle: Mappable {
    /**
     The Edmunds ID. Not very useful.
     */
    public var id: Int?
    
    /**
     The name describing the vehicle style.
     */
    public var name: String?
    
    /**
     The vehicle submodel (or "category"), for example: "Coupe", "Sedan", "SUV", etc.
     */
    public var submodel: String?
    
    /**
     The vehicle trim, for example: "EX"
     */
    public var trim: String?
    
    /**
     The set of colors associated with the vehicle style.
     */
    public var colors: [VehicleColorSet]?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        submodel <- map["submodel.body"]
        trim <- map["trim"]
        colors <- map["colors"]
    }
}
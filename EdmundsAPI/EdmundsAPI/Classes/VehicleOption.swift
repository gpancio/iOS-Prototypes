//
//  VehicleOption.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

public class VehicleOption: Mappable {
    public var id: String?
    public var name: String?
    public var description: String?
    public var equipmentType: String?
    public var availability: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        equipmentType <- map["equipmentType"]
        availability <- map["availability"]
    }
}

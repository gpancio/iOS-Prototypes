//
//  VehicleTransmission.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

public class VehicleTransmission: Mappable {
    public var id: String?
    public var name: String?
    public var transmissionType: String?
    public var numberOfSpeeds: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        transmissionType <- map["transmissionType"]
        numberOfSpeeds <- map["numberOfSpeeds"]
    }
}
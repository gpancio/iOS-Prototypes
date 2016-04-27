//
//  VehicleMakeSet.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

public class VehicleMake: Mappable {
    public var id: String?
    public var name: String?
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

/**
 A set of vehicle makes.
 */
public class VehicleMakeSet: Mappable {
    public var makes: [VehicleMake]?
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        makes <- map["makes"]
    }
    
    public var makesArray: [String] {
        get {
            var makeSet = Set<String>()
            for make in makes! {
                makeSet.insert(make.name!)
            }
            
            return Array(makeSet)
        }
    }
}

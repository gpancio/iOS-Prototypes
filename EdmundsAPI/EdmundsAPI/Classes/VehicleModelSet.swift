//
//  VehicleModelSet.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

public class VehicleModel: Mappable {
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
 A set of vehicle models.
 */
public class VehicleModelSet: Mappable {
    public var models: [VehicleModel]?
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        models <- map["models"]
    }
    
    public var modelsArray: [String] {
        get {
            var modelSet = Set<String>()
            for model in models! {
                modelSet.insert(model.name!)
            }
            
            return Array(modelSet)
        }
    }
}

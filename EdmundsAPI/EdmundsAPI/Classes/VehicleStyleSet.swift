//
//  VehicleStyleSet.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 A set of vehicle styles.
 */
public class VehicleStyleSet: Mappable {
    public var styles: [VehicleStyle]?
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        styles <- map["styles"]
    }
    
    public var submodels: [String] {
        get {
            var submodelSet = Set<String>()
            for style in styles! {
                submodelSet.insert(style.submodel!)
            }
            
            return Array(submodelSet)
        }
    }
}

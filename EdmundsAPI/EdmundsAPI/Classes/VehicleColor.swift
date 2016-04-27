//
//  VehicleColor.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Represents a single vehicle color.
 
 A vehicle color has a name, and optionally:
 - A primaryColorChip, which is a hex color value
 - R, G, B values: integer values describing the RGB components of the color.
 
 Note: the primaryColorChip and RGB values might not be available, for example, for older vehicles.
 */
public class VehicleColor: Mappable {
    /**
     The Edmunds ID. Not useful except, perhaps, for a color lookup later on.
     */
    public var id: String?
    
    /**
     The name of the color.
     */
    public var name: String?
    
    /**
     A hex string describing the color.
     */
    public var primaryColorChip: String?
    
    /**
     The red component of the color, in decimal.
     */
    public var r: Int? {
        didSet {
            r = boundedColorComponent(r)
        }
    }

    /**
     The green component of the color, in decimal.
     */
    public var g: Int? {
        didSet {
            g = boundedColorComponent(g)
        }
    }
    
    /**
     The blue component of the color, in decimal.
     */
    public var b: Int? {
        didSet {
            b = boundedColorComponent(b)
        }
    }
    
    public init() {}
    
    required public init?(_ map: Map) {
        
    }
    
    private func boundedColorComponent(component: Int?) -> Int? {
        if component == nil {
            return nil
        }
        
        if component > 255 {
            return 255
        }
        
        if component < 0 {
            return 0
        }
        
        return component
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        primaryColorChip <- map["colorChips.primary.hex"]
        r <- map["colorChips.primary.r"]
        g <- map["colorChips.primary.g"]
        b <- map["colorChips.primary.b"]
    }
    
    /**
     Tests whether RGB are non-nil before you dereference them.
     */
    public var hasRGB: Bool {
        get {
            return r != nil && g != nil && b != nil
        }
    }

}

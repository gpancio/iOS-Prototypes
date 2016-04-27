//
//  AppTheme.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

/**
 Reads the application's Info.plist to get and apply some specific UI appearance attributes.
 
 Attributes are specified in the Info.plist file by including a top-level Dictionary with the key "App Colors".
 For color attributes, the dictionary contains elements of type String that specify colors in hex form (eg, "FF0000" for red)
 
 "uiLabelTextColor" -> UILabel.textColor
*/
public func applyThemeAppearance() {
    let lblTextColor = getColor("uiLabelTextColor")
    UILabel.appearance().textColor = lblTextColor
}


/**
 Helper for retrieving a color for an attribute defined in Info.plist, under "App Colors"
 
 - Parameter forAttribute: The attribute to retrieve a color for
 - Returns: The color that is set for the attribute. If the attribute cannot be found for whatever reason, UIColor.whiteColor is returned.
 */
public func getColor(forAttribute: String) -> UIColor {
    if  let infoPlist = NSBundle.mainBundle().infoDictionary,
        let config = infoPlist["App Colors"] as? Dictionary<String, AnyObject> {
            if let value = config[forAttribute] as? NSString {
                let color = UIColor(hexString: value as String)
                return color
            }
    }
    
    return UIColor.whiteColor()
}

//
//  EdmundsBranding.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//
import Foundation

public class EdmundsBranding {
    public static func getURL() -> String {
        return "http://www.edmunds.com/?id=apis"
    }

    public static func getLogo() -> UIImage {
        let image = UIImage(named: "220_color", inBundle: NSBundle(URL: NSBundle(forClass: EdmundsBranding.self).URLForResource("EdmundsAPI", withExtension: "bundle")!), compatibleWithTraitCollection: nil)

        return image!
    }
}
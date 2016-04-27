//
//  NextButtonConfig.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

public struct ShowButtonOptions: OptionSetType {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }
    
    public static let ShowNextButton = ShowButtonOptions(rawValue: 1)
    public static let ShowNavItem = ShowButtonOptions(rawValue: 2)
}

public class NextButtonConfig {
    var showFlags: ShowButtonOptions
    public var buttonTitle: String?
    
    public init(showFlags: ShowButtonOptions, buttonTitle: String? = nil) {
        self.showFlags = showFlags
        self.buttonTitle = buttonTitle
    }
    
    public var showNextButton: Bool {
        get {
            return showFlags.contains(.ShowNextButton)
        }
    }
    
    public var showNavItem: Bool {
        get {
            return showFlags.contains(.ShowNavItem)
        }
    }
}
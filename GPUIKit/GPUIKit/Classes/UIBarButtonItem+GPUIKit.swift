//
//  UIBarButtonItem+GPUIKit.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

extension UIBarButtonItem {
    func hide() {
        enabled = false
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.clearColor()], forState: .Normal)
    }
}
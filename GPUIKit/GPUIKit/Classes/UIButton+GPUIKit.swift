//
//  UIButton+GPUIKit.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

extension UIButton {
    func setTargetAndAction(item: UIBarButtonItem) {
        if item.action != nil && item.target != nil {
            addTarget(item.target, action: item.action, forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func setNextButtonTitle(item: UIBarButtonItem, nextButtonTitle: String? = nil) {
        if let title = nextButtonTitle {
            setTitle(title, forState: .Normal)
            return
        }
        
        if let nextTitle = item.title {
            setTitle("Next: " + nextTitle, forState: .Normal)
        } else {
            setTitle("Continue", forState: .Normal)
        }
    }
    
    func sizeAndPlaceNextButton(view: UIView) {
        let height = view.bounds.height / 12
        let y = view.bounds.height - 82 - height
        let margin = 8.0 as CGFloat
        frame = CGRect(x: margin, y: y, width: view.bounds.width - (2 * margin), height: height)
    }
}

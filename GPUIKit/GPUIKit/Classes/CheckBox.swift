//
//  CheckBox.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

public class CheckBox: UIButton {
    
    let checkedImage = UIImage(named: "ic_check_box", inBundle: NSBundle(URL: NSBundle(forClass: CheckBox.self).URLForResource("GPUIKit", withExtension: "bundle")!), compatibleWithTraitCollection: nil)
    let uncheckedImage = UIImage(named: "ic_check_box_outline_blank", inBundle: NSBundle(URL: NSBundle(forClass: CheckBox.self).URLForResource("GPUIKit", withExtension: "bundle")!), compatibleWithTraitCollection: nil)

    public var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    override public func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    public func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
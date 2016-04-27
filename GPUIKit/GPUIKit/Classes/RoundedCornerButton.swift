//
//  RoundedCornerButton.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

/**
 A button with rounded ends.
 */

@IBDesignable
public class RoundedCornerButton: UIButton {
    
    @IBInspectable
    public var borderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.grayColor() { didSet { setNeedsDisplay() } }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        
        contentEdgeInsets.left += bounds.height / 2
        contentEdgeInsets.right += bounds.height / 2
    }
    
    public override func layoutSubviews() {
        layer.cornerRadius = self.bounds.height / 2
        super.layoutSubviews()
    }

}

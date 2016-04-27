//
//  RoundedTextFieldWithIcon.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

/**
 A UITextField that has rounded ends and an optional image that will be shown to the left of the input text.

 By default, the background color is white with 80% transparency.
 */

@IBDesignable
public class RoundedTextFieldWithIcon: UITextField {
    
    var imageView = UIImageView()
    
    @IBInspectable
    var image: UIImage? {
        set(image) {
            imageView.image = image
            setNeedsDisplay()
        }
        
        get {
            return imageView.image
        }
    }
    
    @IBInspectable
    var placeholderText: String? {
        get {
            return placeholder
        }
        
        set {
            placeholder = newValue
            let placeholderString = NSAttributedString(string: placeholder ?? "", attributes: [NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 1.0)])
            attributedPlaceholder = placeholderString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override public func layoutSubviews() {
        layer.cornerRadius = self.bounds.height / 2
        super.layoutSubviews()
    }
    
    func setup() {
        layer.cornerRadius = bounds.height / 2
        
        imageView.frame = CGRectMake(20, 0, 25, 25)
        leftView = imageView
        leftViewMode = UITextFieldViewMode.Always
        
        placeholderText = placeholder
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
    }
    
    override public func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var boundsRect = super.leftViewRectForBounds(bounds)
        boundsRect.origin.x += self.bounds.height / 2
        
        return boundsRect
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        var boundsRect = super.editingRectForBounds(bounds)
        boundsRect.origin.x += self.bounds.height / 2
        
        return boundsRect
    }
    
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        var boundsRect = super.textRectForBounds(bounds)
        boundsRect.origin.x += self.bounds.height / 2
        
        return boundsRect
    }
    
}

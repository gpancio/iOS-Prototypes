//
//  CheckboxLabelView.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

@IBDesignable
public class CheckboxLabelView: UIView {

    @IBOutlet public weak var checkbox: CheckBox!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBInspectable
    public var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    @IBInspectable
    public var checked: Bool = false {
        didSet {
            checkbox?.isChecked = checked
        }
    }
    
    @IBInspectable
    public var checkboxTag: Int = -1 {
        didSet {
            checkbox?.tag = checkboxTag
        }
    }
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CheckboxLabelView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
            
        return view
    }
}

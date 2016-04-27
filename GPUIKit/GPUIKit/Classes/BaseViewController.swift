//
//  ATViewController.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

/**
 Extends UIViewController just to apply a default background color to the root view.
*/
public class BaseViewController: UIViewController, GPNavControllable {
    
    public var nextButtonConfig: NextButtonConfig?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.setDefaultBackgroundColor()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        nextButton?.sizeAndPlaceNextButton(view)
    }
    
    public var nextButton: UIButton? {
        willSet {
            if nextButton != nil {
                nextButton!.removeFromSuperview()
            }
        }
        
        didSet {
            if nextButton != nil {
                nextButton!.sizeAndPlaceNextButton(view)
                view.addSubview(nextButton!)
            }
        }
    }

    public func showNextButton() -> Bool {
        return nextButtonConfig?.showNextButton ?? true
    }
    
    public func nextButtonTitle() -> String? {
        return nextButtonConfig?.buttonTitle
    }
    
    public func showNavItem() -> Bool {
        return nextButtonConfig?.showNavItem ?? false
    }
}





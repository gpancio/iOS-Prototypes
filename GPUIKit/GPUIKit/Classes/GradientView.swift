//
//  GradientView.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

public class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }
        
        theLayer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = self.bounds
    }
    
    override public class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
}

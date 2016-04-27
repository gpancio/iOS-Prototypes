//
//  GPNavControllable.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

public protocol GPNavControllable {
    var nextButton: UIButton? { get set }
    func showNextButton() -> Bool
    func nextButtonTitle() -> String?
    func showNavItem() -> Bool
}

//
//  UIViewController+GPUIKit.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

public extension UIViewController {
    /**
     Dismisses the view controller.
     
     If the view controller is in a UINavigationController stack, then it is popped. Otherwise, it is dismissed.
     */
    public func goBack() {
        if let navController = navigationController {
            navController.popViewControllerAnimated(true)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /**
     Shows a simple error alert dialog with a single "Dismiss" button.
     
     - Parameter message: The message to show.
     */
    public func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
        
    }
}


public extension UIViewController {
    
    /**
     Applies a default background color to the root view of the UIViewController.
     
     The background color is read from Info.plist as follows:
     <key>App Colors</key>
     <dict>
     <key>vcBackgroundColor</key>
     <string>0000FF</string>
     </dict>
     
     A gradient is applied to the color.
     */
    public func setDefaultBackgroundColor() {
        let bkgColor = getColor("vcBackgroundColor")
        self.view.backgroundColor = bkgColor
        
        let gradientView = GradientView(frame: self.view.bounds)
        self.view.insertSubview(gradientView, atIndex: 0)
    }
}


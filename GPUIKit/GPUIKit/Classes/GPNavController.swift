//
//  GPNavController.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

/**
 Extends UINavigationController to provide a customized navigation experience.
 
 This navigation controller basically transforms the view controller's navigationItem.rightBarButtonItem into a button which 
 is placed near the bottom of the screen (called the "nextButton").
 
 For now, set up the nextButton by adding a navigation item and right bar button to the view controller. This can be done via storyboard or
 programmatically. The GPNavController will use rightBarButton item's title as it's title (prepended by "Next: "), and will use any
 target/action assigned to the rightBarButton item (such as a segue).
 */
public class GPNavController: UINavigationController, UINavigationControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        readDynamicVCs()
    }
    
    var dynamicVCs = [String:NextObject]()
    
    class NextObject: NSObject {
        var title: String
        var storyboardName: String
        var bundleIdentifier: String
        var vcIdentifier: String
        var navController: UINavigationController
        
        init(title: String, storyboardName: String, bundleIdentifier: String, vcIdentifier: String, navController: UINavigationController) {
            self.title = title
            self.storyboardName = storyboardName
            self.bundleIdentifier = bundleIdentifier
            self.vcIdentifier = vcIdentifier
            self.navController = navController
        }
        
        func execute() {
            let st = UIStoryboard(name: storyboardName, bundle: NSBundle(identifier: bundleIdentifier))
            let nextVC = st.instantiateViewControllerWithIdentifier(vcIdentifier)
            navController.pushViewController(nextVC, animated: true)
        }
    }
    
    func readDynamicVCs() {
        if  let infoPlist = NSBundle.mainBundle().infoDictionary,
            let config = infoPlist["Dynamic VCs"] as? Array<Dictionary<String, AnyObject>> {
            for vcConfig in config {
                if let origVc = vcConfig["originatingVC"] as? String, let destVC = vcConfig["destination"] as? Dictionary<String, AnyObject> {
                    if let title = destVC["title"] as? String, let bundleIdentifier = destVC["bundleIdentifier"] as? String,
                        let storyboardName = destVC["storyboardName"] as? String, let vcIdentifier = destVC["vcIdentifier"] as? String
                    {
                        dynamicVCs[origVc] = NextObject(title: title, storyboardName: storyboardName, bundleIdentifier: bundleIdentifier, vcIdentifier: vcIdentifier, navController: self)
                    }
                }
            }
        }
    }
    
    func addNextVC(viewController: UIViewController) {
        if let origVcId = viewController.restorationIdentifier {
            if let nextObj = dynamicVCs[origVcId] {
                viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nextObj.title, style: .Plain, target: nextObj, action: #selector(NextObject.execute))
            }
        }
    }
    
    // MARK: - UINavigationControllerDelegate
    
    public func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        addNextVC(viewController)
        
        if let item = viewController.navigationItem.rightBarButtonItem {
            if viewController is GPNavControllable {
                var vc = viewController as! GPNavControllable
                
                if vc.showNextButton() {
                    let nextButton = RoundedCornerButton()
                    
                    nextButton.setNextButtonTitle(item, nextButtonTitle: vc.nextButtonTitle())
                    nextButton.setTargetAndAction(item)
                    
                    vc.nextButton = nextButton
                }
                
                if vc.showNextButton() {
                    item.hide()
                }
            }
        }
    }

}

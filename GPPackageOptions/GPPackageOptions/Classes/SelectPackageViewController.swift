//
//  SelectPackageViewController.swift
//

import UIKit

public protocol SelectPackageViewControllerDelegate: class {
    func packageSelected(package: Package?)
}

public class SelectPackageViewController: ExpandableTableViewControllerDelegate {
    
    public var packages = [Package]()
    public var preselectedPackage: String?
    
    public weak var delegate: SelectPackageViewControllerDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - ExpandableTableViewControllerDelegate
    public func rowSelected(info: ExpandableTableViewItem?) {
        if (info != nil) {
            delegate?.packageSelected((info! as! Package))
        } else {
            delegate?.packageSelected(nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pdtvcEmbed" {
            if let vc = segue.destinationViewController as? ExpandableTableViewController {
                vc.data = packages.map() { return $0 as! ExpandableTableViewItem } // map instead of assign bc otherwise it crashes!
                vc.delegate = self
                vc.preselectedItem = preselectedPackage
            }
        }
    }

}

extension Package: ExpandableTableViewItem {
    public var title: String {
        get { return name }
        set { name = title }
    }
    
    public var detail: String {
        get { return equipString }
        set {}
    }
}
//
//  IdentifyVehicleTableViewController.swift
//  VehicleID
//

import UIKit

public class IdentifyVehicleTableViewController: UITableViewController {

    @IBOutlet weak var yearDetailLabel: UILabel!
    @IBOutlet weak var makeDetailLabel: UILabel!
    @IBOutlet weak var modelDetailLabel: UILabel!
    @IBOutlet weak var styleDetailLabel: UILabel!
    
    public weak var rootViewController: UIViewController?
    
    public var dataMap: DataMap!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        yearDetailLabel?.text = dataMap[Key.Year]?.selectedValue
        makeDetailLabel?.text = dataMap[Key.Make]?.selectedValue
        modelDetailLabel?.text = dataMap[Key.Model]?.selectedValue
        styleDetailLabel?.text = dataMap[Key.Style]?.selectedValue
        
        tableView.reloadData()
    }

    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DataSetTableViewController {
            if let key = segue.identifier {                
                vc.dataSet = dataMap[key]
                vc.dataSetProvider = dataMap
                vc.rootViewController = rootViewController
            }
        }
    }
    
}


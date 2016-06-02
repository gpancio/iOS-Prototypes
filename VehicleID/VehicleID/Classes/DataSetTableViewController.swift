//
//  DataMapTableViewController.swift
//  VehicleID
//

import UIKit
import GPUIKit

public class DataSetTableViewController: ATViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSet: DataSet? {
        didSet {
            if dataSet != nil && dataSet!.validSet.isEmpty {
                dataSet!.populate() { self.updateUI() }
            }
        }
    }
    
    var dataSetProvider: DataSetProvider?
    
    public weak var rootViewController: UIViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func donePressed(sender: AnyObject) {
        if let navController = navigationController, rootVC = rootViewController {
            navController.popToViewController(rootVC, animated: true)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        if let selectedString = dataSet?.selectedValue {
            if let index = dataSet?.validSet.indexOf(selectedString) {
                tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Middle)
                nextButton?.enabled = true
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet?.validSet.count ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let value = dataSet?.validSet[indexPath.row] {
            cell.textLabel?.text = value
            let selectedString = dataSet?.selectedValue
            if selectedString != nil && value == selectedString {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dataSet?.selectIndex(indexPath.row)
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .Checkmark
        }
        
        nextButton?.enabled = true
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        dataSet?.deselectValue()
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
        }
        
        nextButton?.enabled = false
    }
    
    func updateUI() {
        if let tableView = self.tableView {
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesInRange: range)
            tableView.reloadSections(sections, withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DataSetTableViewController {
            if let key = segue.identifier {
                if let nextDataSet = dataSetProvider?.dataSet(forKey: key) {
                    vc.dataSetProvider = dataSetProvider
                    vc.dataSet = nextDataSet
                    vc.rootViewController = rootViewController
                }
            }
        }
    }

}

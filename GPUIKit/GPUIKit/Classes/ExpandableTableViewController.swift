//
//  ExpandableTableViewController.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

let estimatedHeight: CGFloat = 88
let topInset: CGFloat = 20

public protocol ExpandableTableViewControllerDelegate: class {
    func rowSelected(info: ExpandableTableViewItem?)
}

public protocol ExpandableTableViewItem {
    var title: String { get set }
    var detail: String { get set }
}

public class ExpandableTableViewController: UITableViewController {
    public var data = [ExpandableTableViewItem]()
    public var preselectedItem: String?
    var selectedItem: ExpandableTableViewItem?
    
    public weak var delegate: ExpandableTableViewControllerDelegate?
    
    var selectedCheckbox: CheckBox?
    
    @IBAction func checkBoxTapped(sender: AnyObject) {
        if let box = sender as? CheckBox {
            if box.isChecked {
                selectedItem = data[sender.tag]
                if sender !== selectedCheckbox {
                    selectedCheckbox?.isChecked = false
                    selectedCheckbox = sender as? CheckBox
                }
            } else {
                selectedItem = nil
            }
        }
    }
        
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.registerClass(ExpandableTableViewCell.classForCoder(), forCellReuseIdentifier: "detailCell")
        tableView.registerNib(UINib(nibName: "ExpandableTableViewCell", bundle: NSBundle(forClass: ExpandableTableViewCell.self)), forCellReuseIdentifier: "detailCell")
        tableView.separatorStyle = .None

        tableView.contentInset.top = topInset
        tableView.estimatedRowHeight = estimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if preselectedItem != nil {
            for index in 0...data.count {
                if data[index].title == preselectedItem {
                    selectedItem = data[index]
                    break
                }
            }
            preselectedItem = nil
        }
    }
    
    override public func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.rowSelected(selectedItem)
    }

    // MARK: - Table view data source

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! ExpandableTableViewCell
        
        cell.title = data[indexPath.row].title
        cell.detail = data[indexPath.row].detail
        cell.checkbox.tag = indexPath.row
        cell.checkbox.isChecked = (data[indexPath.row].title == selectedItem?.title)
        cell.checkbox.addTarget(self, action: #selector(checkBoxTapped), forControlEvents: .TouchUpInside)
        
        if cell.checkbox.isChecked {
            selectedCheckbox = cell.checkbox
        }
        
        return cell
    }
    
    override public func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let selectedIndex = tableView.indexPathForSelectedRow where selectedIndex == indexPath {
            tableView.beginUpdates()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            tableView.endUpdates()
            
            return nil
        }
        
        return indexPath
    }
    
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

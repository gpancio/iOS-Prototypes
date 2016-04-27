//
//  MultiSelectTableViewController.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

public protocol SelectionListener: class {
    func selectionChanged(option: (String, Bool))
}

public class MultiSelectTableViewController: UITableViewController {

    /**
     The options to display. This should be a dictionary where the keys are the titles to display
     and the values denote whether that option is selected.
     */
    public var options = [String:Bool]() {
        didSet {
            optionsArray = [String](options.keys)
        }
    }
    var optionsArray = [String]()
    
    public weak var listener: SelectionListener?
    
    @IBAction func checkboxPressed(sender: AnyObject) {
        let option: String = optionsArray[sender.tag]
        if let oldValue: Bool = options[option] {
            options.updateValue(!oldValue, forKey: option)
            listener?.selectionChanged(option, !oldValue)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("multiselectCell", forIndexPath: indexPath)
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let customCell = cell.contentView.subviews[0] as? CheckboxLabelView {
            let option = optionsArray[indexPath.row]
            customCell.title = option
            customCell.checked = options[option] ?? false
            customCell.checkboxTag = indexPath.row
            customCell.checkbox.addTarget(self, action: #selector(checkboxPressed), forControlEvents: .TouchUpInside)
        }
    }

}

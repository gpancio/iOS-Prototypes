//
// SelectOptionsViewController.swift
//

import UIKit
import GPUIKit

public protocol SelectOptionsViewControllerDelegate: class {
    func optionsSelected(selectedOptions: [String:Bool])
}

public class SelectOptionsViewController: SelectionListener {
    
    public var options = [String:Bool]()
    
    public weak var delegate: OptionsViewControllerDelegate?
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        var filteredOptions = [String:Bool]()
        
        switch sender.selectedSegmentIndex {
        case 0:
            filteredOptions = options
        case 1:
            for (key, value) in options {
                if value {
                    filteredOptions[key] = value
                }
            }
            
        case 2:
            for (key, value) in options {
                if !value {
                    filteredOptions[key] = value
                }
            }
        default:
            break
        }
        
        if let tvc = self.childViewControllers[0] as? MultiSelectTableViewController {
            tvc.options = filteredOptions
            tvc.tableView.reloadData()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public override func viewWillDisappear(animated: Bool) {
        delegate?.optionsSelected(options)
    }
    
    // MARK: - SelectionListener
    public func selectionChanged(option: (String, Bool)) {
        options[option.0] = option.1
    }

    // MARK: - Navigation

    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "votvcEmbed" {
            if let votvc = segue.destinationViewController as? MultiSelectTableViewController {
                votvc.options = options
                votvc.listener = self
            }
        }
    }

}

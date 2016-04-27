//
//  ExpandableTableViewCell.swift
//  GPUIKit
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import UIKit

public class ExpandableTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showDetailIcon: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var checkbox: CheckBox!
    
    public var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    public var detail: String? {
        didSet {
            detailsTextView?.text = detail
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        stackView.arrangedSubviews.last?.hidden = true
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.last?.hidden = true
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                            self.stackView.arrangedSubviews.last?.hidden = !selected
                        },
            completion: nil)
        
        let rotate: CGFloat = selected ? CGFloat(M_PI_2) : 0
        UIView.animateWithDuration(0.35,
            animations: {
                self.showDetailIcon.transform = CGAffineTransformMakeRotation(rotate)
                                    
                if (selected) {
                    self.stackView.arrangedSubviews.first?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.30)
                    self.stackView.arrangedSubviews.last?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.30)
                } else {
                    self.stackView.arrangedSubviews.first?.backgroundColor = UIColor.clearColor()
                    self.stackView.arrangedSubviews.last?.backgroundColor = UIColor.clearColor()
                }
            }
        )
    }
    
}

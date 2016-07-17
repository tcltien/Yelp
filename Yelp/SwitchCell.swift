//
//  SwitchCell.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/17/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCellDidSwitchChanged(switchCell: SwitchCell)
}
class SwitchCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func switchValueChanged() {
        print("Switch")
        delegate?.switchCellDidSwitchChanged?(self)
    }
   
}

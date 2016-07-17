//
//  SelectCell.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/17/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

class SelectCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkImageView.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

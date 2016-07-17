//
//  BussinessTableViewCell.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/12/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

class BussinessTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            posterImage.setImageWithURL(business.imageURL!)
            categoryLabel.text = business.categories
            addressLabel.text = business.address
            distanceLabel.text = business.distance
            ratingImage.setImageWithURL(business.ratingImageURL!)
            reviewerLabel.text = "\(business.reviewCount!) Reviews"
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImage.layer.cornerRadius = 3
        posterImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

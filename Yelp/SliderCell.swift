//
//  SliderCell.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/17/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

@objc protocol SliderCellDelegate {
    optional func sliderCell(sliderCell: SliderCell, didSliderChange params: [[String: AnyObject]])
}

class SliderCell: UITableViewCell {

    weak var delegate: SliderCellDelegate?
    
    @IBOutlet weak var onDealChange: UISwitch!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sliderDistance: UISlider!
    var params = [[String: AnyObject]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onDealChange.on = false
        getParams()
        onDealChange.addTarget(self, action: #selector(SliderCell.didSliderChange), forControlEvents: UIControlEvents.ValueChanged)
        
        sliderDistance.addTarget(self, action: #selector(SliderCell.didSliderChange), forControlEvents: UIControlEvents.ValueChanged)
        
        sortSegment.addTarget(self, action: #selector(SliderCell.didSliderChange), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSliderChange(sender: AnyObject) {
        distanceLabel.text = "\(sliderDistance.value) mi"
    }
    func didSliderChange() {
        delegate?.sliderCell?(self, didSliderChange: getParams())
    }
    
    func getParams() -> [[String: AnyObject]] {
        var params = [[String: AnyObject]]()
        params.append(["Deal": onDealChange.on])
        let segIndex = sortSegment.selectedSegmentIndex
        params.append(["Sort": sortSegment.titleForSegmentAtIndex(segIndex)!])
        params.append(["Distance": sliderDistance.value])
        return params
    }
}

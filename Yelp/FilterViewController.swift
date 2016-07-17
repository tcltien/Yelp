//
//  FilterViewController.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/12/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
    optional func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String:AnyObject])
}
class FilterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate : FilterViewControllerDelegate?
    
    var category: [[String:String]]!
    var switchState = [[String: AnyObject]]()
    var switchOn = false
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        category = yelpCategories()
        tableView.dataSource = self
        tableView.delegate = self
        
        switchOn = selectedCategory != ""
        tableView.tableFooterView = UIView()
       
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func cancelFilter(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func searchFilter(sender: UIBarButtonItem) {
        var filters = [String: AnyObject]()
        
        if  selectedCategory != "" {
            filters["categories"] = selectedCategory
        } else {
            filters["categories"] = category[0]["name"]!
        }
        if (switchState.count > 0) {
            filters["deal"] = switchState[0]["Deal"] ?? false
            filters["sort"] = switchState[1]["Sort"]
            filters["distance"] = switchState[2]["Distance"]
        }
        delegate?.filterViewController?(self, didUpdateFilters: filters)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func yelpCategories() -> [[String:String]] {
        return [["name": "Arcades", "code": "arcades"],
                ["name": "Cinema", "code": "cinema"],
                ["name": "Farms", "code": "farms"],
                ["name": "Festivals", "code": "festivals"],
                ["name": "Jazz & Blues", "code": "jazzandblues"]]
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return category.count + 1
        default: return 0
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        header.backgroundColor = UIColor.clearColor()
        return header
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
        if switchOn {
            if indexPath.section == 0 {
                return 250
            }
            return 44
        } else {
            switch indexPath.section {
            case 0: return 250
            case 1: return indexPath.row == 0 ? 44 : 0
            default: return 0
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("SliderCell", forIndexPath: indexPath) as! SliderCell
            cell.delegate = self
            return cell
            
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
                cell.onSwitch.on = switchOn
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("SelectCell", forIndexPath: indexPath) as! SelectCell
                let cate = category[indexPath.row - 1]
                cell.languageLabel.text = cate["name"]
                cell.checkImageView.hidden = cate["name"] != selectedCategory
                return cell
            }
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row != 0 {
                selectedCategory = category[indexPath.row - 1]["name"]!
                tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .None)
            }
        }
    }
}

extension FilterViewController: SliderCellDelegate {
    
    func sliderCell(sliderCell: SliderCell, didSliderChange params: [[String: AnyObject]]) {
        switchState  = params
    }
    
}
extension FilterViewController: SwitchCellDelegate {
    
    func switchCellDidSwitchChanged(switchCell: SwitchCell) {
        
        switchOn = switchCell.onSwitch.on
        if selectedCategory == "" {
            selectedCategory = category[0]["name"]!
        }
        tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
    }
    
}



    


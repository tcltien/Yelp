//
//  BussinessViewController.swift
//  Yelp
//
//  Created by Le Huynh Anh Tien on 7/12/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit
import MBProgressHUD

class BussinessViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var businesses:[Business]?
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        doSearch("VietNam")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func doSearch(params: String) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // Get Data from API
        Business.searchWithTerm(params, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
            self.tableView.reloadData()
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
        });
    }
    

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filterViewController = navigationController.topViewController as! FilterViewController
        
        filterViewController.delegate = self
    }
    
    
 
    
}

extension BussinessViewController: UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bCell") as! BussinessTableViewCell
        
        cell.business = businesses![indexPath.row]
        return cell
    }
    
    func filterViewController(filterViewController: FilterViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let categories = filters["categories"] as? [String]
        print(filters)
        let sort: YelpSortMode
        if let so = filters["sort"] {
            switch so as! String {
                case "Distance":
                sort = YelpSortMode.Distance
                case "HighRated":
                sort = YelpSortMode.HighestRated
                default:
                sort = YelpSortMode.BestMatched
            }
        } else {
            sort = YelpSortMode.BestMatched
        }
        
        
        Business.searchWithTerm("Arts & Entertainment", sort: sort, categories: categories, deals: filters["deal"] as? Bool) { (businesses: [Business]!, error : NSError!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
                self.tableView.setContentOffset(CGPointZero, animated: true)
            
        }
    }
    
    
}

extension BussinessViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        doSearch(searchBar.text!)
        self.tableView.setContentOffset(CGPointZero, animated: true)
    }
}

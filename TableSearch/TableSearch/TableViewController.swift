//
//  TableViewController.swift
//  TableSearch
//
//  Created by neil-r on 9/22/15.
//  Copyright (c) 2015 neil-r. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate   {

    // MARK: Private Variables
    private let TableViewData = Model()
    private var destinationValue: NSString?
    private struct Storyboard{
        static let segueBackToMainVC = "Return to MainVC"
        static let cellID = "Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Search the List"
    }
    
    //MARK:  Table view methods.  
    //All logic around data is handled in TableViewData (Model).  Tableview methods are used
    //for both activeSearch and inactiveSearch.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(Storyboard.cellID) as UITableViewCell?
        cell?.textLabel?.text = TableViewData.getCellTitle(section: indexPath.section, row: indexPath.row)
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewData.getRowCountForSectionNumber(section)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableViewData.getSectionCount()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableViewData.getSectionNameForSectionNumber(section)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellSelected = tableView.cellForRowAtIndexPath(indexPath)
        destinationValue = cellSelected?.textLabel?.text
        
        performSegueWithIdentifier(Storyboard.segueBackToMainVC, sender: nil)
    }
    
    //MARK: Search Bar methods.  
    //When search is started a flag in TableViewData (model) is flipped to true.
    //This flag helps the model to determine which data to provided: section and rows (search = false)
    //or just rows (search = true)
    @IBOutlet weak var searchBar: UISearchBar!
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        TableViewData.isSearchActive(true)
        TableViewData.filterListForSearch(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        TableViewData.isSearchActive(false)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
         //TableViewData.isSearchActive(true)
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
         TableViewData.isSearchActive(false)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
         TableViewData.isSearchActive(false)
    }
    
    //MARK: Unwind segue.  
    //Will pass selected Destination back to MainViewController to be displayed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.segueBackToMainVC{
            if let mainVC = segue.destinationViewController as? MainViewController{
                mainVC.destinationLabel.text = destinationValue! as String
            }
        }
    }
}

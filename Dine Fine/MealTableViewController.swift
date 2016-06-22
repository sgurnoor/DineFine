//
//  LunchTableViewController.swift
//  Dine Fine
//
//  Created by Meghan Campano on 12/1/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //carries dining hall from selection
    var selectedDiningHall: DiningLocation?
    var meals = [Meal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hides extra rows
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        //gets meals from API
        MenusAPIManager().loadMeals(selectedDiningHall!, forDate: NSDate()) { (mealsFromAPI, hoursFromAPI, addressFromAPI, typeFromAPI) -> Void in
            
            self.meals = mealsFromAPI
            
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.tableView.reloadData()
                
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Meal Cell", forIndexPath: indexPath)
        //sets the meals to the label of the cells
        if indexPath.section == 0 {
            cell.textLabel?.text = meals[indexPath.row].type
            cell.textLabel?.textColor = UIColor.whiteColor()
        }
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let mitvc = segue.destinationViewController as? MenuItemsTableViewController {
            if segue.identifier == "Select Meal" {
                //passes on meals and courses to menu items page
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    mitvc.title = meals[indexPath.row].type
                    mitvc.course = meals[indexPath.row].courses!
                    
                }
            }
        }
    }
    
    
}

//
//  MenuItemsTableViewController.swift
//  Dine Fine
//
//  Created by Meghan Campano on 12/3/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class MenuItemsTableViewController: UITableViewController {
    
    var course = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //number of courses is the number of sections
        return course.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //the number of menu items in each course
        return course[section].menuItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Meal Cell", forIndexPath: indexPath)
        
        //sets the label to the the menu item name
        cell.textLabel?.text = course[indexPath.section].menuItems[indexPath.row].name
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //names section after each course
        let title = course[section].name
        return title
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    //annimates the cells to bounce when loaded
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ntvc = segue.destinationViewController as? NutritionTableViewController {
            if segue.identifier == "Select Item" {
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    //passes on menu items to nutrition
                    ntvc.title = course[indexPath.section].menuItems[indexPath.row].name
                    ntvc.item = course[indexPath.section].menuItems[indexPath.row]
                }
            }
        }
    }
}

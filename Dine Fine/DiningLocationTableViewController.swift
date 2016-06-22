//
//  DiningLocationTableViewController.swift
//  Dine Fine
//
//  Created by Meghan Campano on 11/28/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class DiningLocationTableViewController: UITableViewController {
    
    //Mark: Model
    
    var diningHall = [DiningLocation]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //loads dining halls from API
        MenusAPIManager.loadDiningHalls { (diningLocationsFromAPI) -> Void in
            self.diningHall = diningLocationsFromAPI
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
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
        //number of dining halls
        return diningHall.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Dining Hall Cell", forIndexPath: indexPath)
        //sets dining hall name as label for cell
        if indexPath.section == 0 {
            cell.textLabel?.text = diningHall[indexPath.row].name
            //sets text color to white
            cell.textLabel?.textColor = UIColor.whiteColor()
        }
        return cell
    }
    
    
    
    //adds animation to the cells to bounce
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    //animates the table view cells when they load
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
            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Dining Hall Info" {
            
            if let ditvc = segue.destinationViewController as? DiningInfoViewController {
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    // passes dining hall and title to next page
                    let selectedDiningLocation = diningHall[indexPath.row]
                    ditvc.diningHall = selectedDiningLocation
                    ditvc.title = selectedDiningLocation.name
                }
            }
        }
        
    }
    
    
}

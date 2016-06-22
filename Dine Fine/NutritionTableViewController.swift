//
//  NutritionTableViewController.swift
//  Dine Fine
//
//  Created by Meghan Campano on 12/3/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class NutritionTableViewController: UITableViewController {
    
    var item: MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //one section for serving size, the other for nutrition info
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //serving size
        if section == 0 {
            return 1
        }
            //nutrition info
        else if section == 1 {
            return (item?.nutritionInfo.count)!
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Nutrition Cell", forIndexPath: indexPath)
        
        //serving size label
        if indexPath.section == 0 {
            cell.textLabel?.text = item!.servingSize
            cell.textLabel?.textColor = UIColor.whiteColor()
            
        }
            //nutrition label
        else if indexPath.section == 1 {
            //gets all of the facts from the array and displays them
            let keys = Array(item!.nutritionInfo.keys)
            let key = keys[indexPath.row]
            let fact = item!.nutritionInfo[key]!
            let nutritionFact = "\(key): \(fact)"
            cell.textLabel?.text = nutritionFact
            cell.textLabel?.textColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Serving Size"
            
        } else if section == 1 {
            return "Nutrition Information"
            
        } else {
            return nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    //animates table to bounce
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
    
}

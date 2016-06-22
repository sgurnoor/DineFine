//
//  DiningHours.swift
//  Dine Fine
//
//  Created by Gurnoor Singh on 12/10/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class DiningHours: UIViewController {

    @IBOutlet weak var diningHallHours: UITextView!
    
    var hoursArray = [String]()
    var diningHall: DiningLocation?
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        //loads dining hall hours from API
        MenusAPIManager().loadMeals(diningHall!, forDate: NSDate()) { (mealsFromAPI, hoursFromAPI, addressFromAPI, typeFromAPI) -> Void in
            self.hoursArray = hoursFromAPI
            var multiLineHours = ""
            multiLineHours += self.hoursArray.joinWithSeparator("\n")
            
            
            
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.diningHallHours.text = multiLineHours
                self.view.reloadInputViews()
            })
            
        }
    }
    
}

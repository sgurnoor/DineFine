//
//  MainMenuViewController.swift
//  Dine Fine
//
//  Created by Noel Shaye Grant on 12/14/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var namelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets main menu to say hello, (username)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("name_preference") != nil {
            namelabel.text = "Hello, \(NSUserDefaults.standardUserDefaults().objectForKey("name_preference")!)!"
        }
        else {
            namelabel.text = "Hello, user"
        }
        
        
        // updates main menu name whenever user changes it
        NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification,
            object: nil,
            queue: nil) { (notification) -> Void in
                if NSUserDefaults.standardUserDefaults().objectForKey("name_preference") != nil {
                    self.namelabel.text = "Hello, \(NSUserDefaults.standardUserDefaults().objectForKey("name_preference")!)!"
                }
                else {
                    self.namelabel.text = "Hello, user"
                }

        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

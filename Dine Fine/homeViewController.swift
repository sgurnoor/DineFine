//
//  homeViewController.swift
//  Dine Fine
//
//  Created by Gurnoor Singh on 12/12/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {


    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        
        
        continueButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.continueButton.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

}



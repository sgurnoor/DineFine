//
//  Course.swift
//  Menus
//
//  Created by Maxim Aleksa on 9/12/15.
//  Copyright © 2015 Maxim Aleksa. All rights reserved.
//

import Foundation

/**
 * Represents a set of dishes.
 *
 * Stores the ID, the name, and the address of the dining hall.
 */
class Course {
    let name: String
    let menuItems: [MenuItem]
    
    init(json: NSDictionary) {
        
        self.name = json["name"] as? String ?? "?"
        var menuItemsToAdd = [MenuItem]()
        if let menuItemObjects = json["menuitem"] as? [NSDictionary] {
            for menuItemObject in menuItemObjects {
            
                menuItemsToAdd.append(MenuItem(json: menuItemObject))
            }
        } else if let menuItemObject = json["menuitem"] as? NSDictionary {
            
            menuItemsToAdd.append(MenuItem(json: menuItemObject))
        }
        
        self.menuItems = menuItemsToAdd
    }
}
//
//  DiningLocation
//  Menus
//
//  Created by Maxim Aleksa on 9/12/15.
//  Copyright © 2015 Maxim Aleksa. All rights reserved.
//

import Foundation

/**
 * Represents a dining hall, such as South Quad.
 *
 * Stores the ID, the name, and the address of the dining hall.
 */
class DiningLocation {
    // api identifier (e.g. MARKETPLACE)
    let id: String
    
    // display name (e.g. Hill Dining Center)
    let name: String
    
    var address: Address?
    struct Address {
        var street: String = ""
        var street2: String = ""
        var city: String = "Ann Arbor"
        var state: String = "MI"
        var zip: String = "48109"
    }
    
    
    var type: DiningLocationType?
    // dining hall or café
    enum DiningLocationType: String {
        case DiningHall = "Dining Hall"
        case Cafe = "Café"
    }
    
    
    init(id: String, name: String, address: Address? = nil, type: DiningLocationType? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.type = type
    }
}
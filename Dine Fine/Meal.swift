//
//  Meal.swift
//  Menus
//
//  Created by Maxim Aleksa on 9/12/15.
//  Copyright © 2015 Maxim Aleksa. All rights reserved.
//

import Foundation

class Meal {
    
    // Represents a meal type, such as Breakfast, Lunch, or Dinner.
    let type: String
    
    var courses: [Course]?
    
    init(mealType: String, courses: [Course]?) {
        self.type = mealType.capitalizedString
        self.courses = courses
    }
}
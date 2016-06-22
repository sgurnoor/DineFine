//
//  MenuItem.swift
//  Menus
//
//  Created by Maxim Aleksa on 9/12/15.
//  Copyright © 2015 Maxim Aleksa. All rights reserved.
//

import Foundation



/**
 * Represents a menu item (e.g. Mac and Cheese).
 *
 * Stores the name, serving size, traits and nutritional information.
 */
class MenuItem {
    
    enum Trait: String {
        case Vegan, MHealthy, GlutenFree = "Gluten Free", Vegetarian
    }
    
    let name: String
    let traits: [Trait]
    let allergens: [String]
    let description: String
    //- grams per serving
    let servingSize: String
    let grams: Int
    let sellPrice: Double?
    let nutritionInfo: [String: String]
    
    
    init(json: NSDictionary) {
        name = json["name"] as? String ?? "?"
        
        var traitsToAdd = [Trait]()
        if let traitsObject = json["trait"] as? [String: String] {
            for (_, value) in traitsObject {
                switch value {
                    
                case "vegan":
                    traitsToAdd.append(Trait.Vegan)
                case "mhealthy":
                    traitsToAdd.append(Trait.MHealthy)
                case "glutenfree":
                    traitsToAdd.append(Trait.GlutenFree)
                case "vegetarian":
                    traitsToAdd.append(Trait.Vegetarian)
                default:
                    break
                }
            }
        }
        traits = traitsToAdd
        
        var allergensToAdd = [String]()
        if let allergensObject = json["allergens"] as? [String: String] {
            for (_, value) in allergensObject {
                allergensToAdd.append(value)
            }
        }
        allergens = allergensToAdd
        
        description = json["description"] as? String ?? "?"
        servingSize = json["itemsize"]?["serving_size"] as? String ?? "?"
        grams = json["itemsize"]?["portion_size"] as? Int ?? (json["itemsize"]?["portion_size"] as? NSString)?.integerValue ?? 0
        sellPrice = (json["itemsize"]?["sell_price"] as? NSString)?.doubleValue
        
        var nutritionInfoToAdd = [String: String]()
        if let nutritionObjects = json["itemsize"]?["nutrition"] as? [String: String] {
            for (abbr, value) in nutritionObjects {
                if let factName = MenuItem.NutritionFacts[abbr] {
                    nutritionInfoToAdd[factName] = value
                }
            }
        }
        nutritionInfo = nutritionInfoToAdd
    }
    
    
    static let NutritionFacts = [
        "pro": "Protein",
        "fat": "Fat",
        "kj": "Calories from Fat",
        "cho": "Carbohydrate",
        "kcal": "Calories",
        "sfa": "Saturated Fat",
        "tdfb": "Total Dietary Fiber",
        "b1": "Vitamin B1",
        "b2": "Vitamin B2",
        "nia": "Niacin",
        "fol": "Folic Acid",
        "b12": "Vitamin B12",
        "b6": "Vitamin B6",
        "vitc": "Vitamin C",
        "vite": "Vitamin E",
        "ca": "Calcium",
        "mg": "Magnesium",
        "fe": "Iron",
        "zn": "Zinc",
        "vtaiu": "Vitamin A",
        "chol": "Cholesterol",
        "fatrn": "Trans Fat",
        "sugar": "Sugar",
        "na": "Sodium",
        "pro_p": "Protein PDV",
        "fat_p": "Fat PDV",
        "cho_p": "Carbohydrates PDV",
        "kcal_p": "Calories PDV",
        "sfa_p": "Saturated Fat PDV",
        "tdfb_p": "Total Dietary Fiber PDV",
        "b1_p": "Vitamin B1 PDV",
        "b2_p": "Vitamin B2 PDV",
        "nia_p": "Niacin PDV",
        "fol_p": "Folic Acid PDV",
        "b12_p": "Vitamin B12 PDV",
        "b6_p": "Vitamin B6 PDV",
        "vitc_p": "Vitamin C PDV",
        "vite_p": "Vitamin E PDV",
        "ca_p": "Calcium PDV",
        "mg_p": "Magnesium PDV",
        "fe_p": "Iron PDV",
        "zn_p": "Zinc PDV",
        "vtaiu_p": "Vitamin A PDV",
        "chol_p": "Cholesterol PDV",
        "fatrn_p": "Trans Fat PDV",
        "sugar_p": "Sugar PDV",
        "na_p": "Sodium PDV"
    ]
}
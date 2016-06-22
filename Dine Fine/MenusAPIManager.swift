//
//  MenusAPIManager.swift
//  MiMeals
//
//  Created by Maxim Aleksa on 9/12/15.
//  Copyright © 2015 Maxim Aleksa. All rights reserved.
//

import Foundation

class MenusAPIManager {
    
    
    func loadMeals(diningHall: DiningLocation, forDate date: NSDate = NSDate(), completionHandler: (meals: [Meal], hours: [String], address: DiningLocation.Address, type: DiningLocation.DiningLocationType?) -> Void) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let stringDate = formatter.stringFromDate(date)
        
        let url = "http://api.studentlife.umich.edu/menu/xml2print.php?view=json&location=\(diningHall.id)&date=\(stringDate)"
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { data, response, error in
            
            if error != nil {
                print(error)
                return
            }
            
            if data != nil {
                
                do {
                    var hours = [String]()
                    var address = DiningLocation.Address()
                    var meals = [Meal]()
                    guard let jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary else { throw MenusAPIError.UnexpectedFormat }
                    
                    // type
                    var type: DiningLocation.DiningLocationType?
                    if let diningLocationType = jsonObject["type"] as? String where diningLocationType == "B" {
                        type = DiningLocation.DiningLocationType.DiningHall
                    }
                    
                    // hours
                    guard let hourDetails = jsonObject["details"]?["detail"] as? [AnyObject] else { throw MenusAPIError.UnexpectedFormat }
                    guard let mealObjects = jsonObject["menu"]?["meal"] as? [NSDictionary] else { throw MenusAPIError.UnexpectedFormat }
                    
                    
                    for hourDetail in hourDetails {
                        if let hour = hourDetail as? String {
                            hours.append(hour)
                        }
                    }
                    
                    // address
                    address.street = jsonObject["address"]?["address1"] as? String ?? ""
                    address.street2 = jsonObject["address"]?["address2"] as? String ?? ""
                    address.city = jsonObject["address"]?["city"] as? String ?? ""
                    address.state = jsonObject["address"]?["state"] as? String ?? ""
                    address.zip = jsonObject["address"]?["postalcode"] as? String ?? ""
                    
                    // meals
                    for mealObject in mealObjects {
                        
                        guard let mealName = mealObject["name"] as? String else { continue }
                        
                        var courses: [Course]?
                        if let coursesObjects = mealObject["course"] as? [NSDictionary] {
                            courses = [Course]()
                            for courseObject in coursesObjects {
                                
                                let courseToAdd = Course(json: courseObject)
                                courses?.append(courseToAdd)
                            }
                        } else {
                            continue
                        }
                        let mealToAdd = Meal(mealType: mealName, courses: courses)
                        meals.append(mealToAdd)
                    }
                    
                    completionHandler(meals: meals, hours: hours, address: address, type: type)
                } catch _ {
                    // error
                    completionHandler(meals: [], hours: [], address: DiningLocation.Address(), type: nil)
                }
            }
        }
        task.resume()
    }
    
    class func loadDiningHalls(completionHandler: (diningLocations: [DiningLocation]) -> Void)  {
        
        let url = "http://api.studentlife.umich.edu/menu/menu_generator/service_units.php"
        let rejectedKeywords = ["eventmaster", "catering", "em", "pantry"]
        let excludedLocations = ["oxford"]
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { data, response, error in
            
            if error != nil {
                print(error)
                return
            }
            
            if data != nil {
                
                do {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    
                    var result = [DiningLocation]()
                    
                    if let diningHallData = jsonData as? [[String: String]] {
                        
                        for diningHallObject in diningHallData {
                            
                            guard let value = diningHallObject["optionValue"] else { break }
                            guard let display = diningHallObject["optionDisplay"] else { break }
                            
                            // filter out invalid locations
                            var rejected = false
                            for keyword in rejectedKeywords {
                                
                                if value.lowercaseString.rangeOfString(keyword) != nil {
                                    rejected = true
                                    break
                                }
                            }
                            if excludedLocations.contains(value.lowercaseString) {
                                rejected = true
                            }
                            
                            if !rejected {
                                
                                // replace spaces with +
                                let diningHallID = value.stringByReplacingOccurrencesOfString(" ", withString: "+")
                                let diningHallToAdd = DiningLocation(id: diningHallID, name: display)
                                result.append(diningHallToAdd)
                            }
                            
                        }
                    }
                    
                    
                    
                    completionHandler(diningLocations: result)
                } catch _ {
                    // error
                    completionHandler(diningLocations: [])
                }
            }
        }
        task.resume()
    }
}

enum MenusAPIError: ErrorType {
    case UnexpectedFormat
}
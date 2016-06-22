//
//  DiningInfoViewController.swift
//  Dine Fine
//
//  Created by Gurnoor Singh on 12/11/15.
//  Copyright © 2015 iOS Rangers. All rights reserved.
//

import UIKit
import MapKit

class DiningInfoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var diningHallAddress: UILabel!
    
    @IBOutlet weak var diningHallMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var addressArray = DiningLocation.Address()
    
    var diningHall: DiningLocation?
    
    var meals = [Meal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MenusAPIManager().loadMeals(diningHall!, forDate: NSDate()) { (mealsFromAPI, hoursFromAPI, addressFromAPI, typeFromAPI) -> Void in
            self.addressArray = addressFromAPI
            let stringAddress = "Address: \n \(self.addressArray.street) \(self.addressArray.street2) \n \(self.addressArray.city),  \(self.addressArray.state) \(self.addressArray.zip)"
            
            
            self.meals = mealsFromAPI
            
            
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.diningHallAddress.text = stringAddress
                
            })
            //puts a placemark on map for the dining hall location provided
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(stringAddress, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error)
                }
                if let placemark = placemarks?.first {
                    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    self.diningHallMap.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = self.diningHall?.name
                    self.diningHallMap.addAnnotation(annotation)
                    
                }
            })
            
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Select Menu" {
            
            if let mtvc = segue.destinationViewController as? MealTableViewController {
                mtvc.title = "Select a Meal"
                mtvc.selectedDiningHall = diningHall
            }
        }
        
        
        
        if segue.identifier == "showHours" {
            if let dhvc = segue.destinationViewController as? DiningHours {
                dhvc.title = "Dining Hours"
                dhvc.diningHall = diningHall
            }
        }
        
    }
    
    // Commented out for future implementation of user's current location
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
    let location = locations.last
    
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
    
    self.diningHallMap.setRegion(region, animated: true)
    
    self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
    print("Errors: " + error.localizedDescription)
    }
    */
    
}
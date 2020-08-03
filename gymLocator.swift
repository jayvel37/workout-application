//
//  gymLocator.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class gymLocatorController: UIViewController, MKMapViewDelegate, UISearchBarDelegate
{
    
    //retrieve the city from the model
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var Map: MKMapView!
    
    //function to toggle the view of the search bar
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        //switch statement to set the satellite
        switch(selectedScope)
        {
        case 0:
            Map.mapType = MKMapType.standard
        case 1:Map.mapType = MKMapType.satellite
        default:Map.mapType = MKMapType.standard
        }
        
    }
    
    func showLocation()
    {
        let geoCoder = CLGeocoder();
        
        var addressString:String!
        let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
        ref.observe(.value, with: { snapshot in
            let dict = snapshot.value as? [String:Any]
            
            addressString = dict!["city"] as? String
            
            //this will have to be the input they enter for city
            CLGeocoder().geocodeAddressString(addressString, completionHandler:
                {(placemarks, error) in
                    
                    if error != nil {
                        print("Geocode failed: \(error!.localizedDescription)")
                    } else if placemarks!.count > 0 {
                        let placemark = placemarks![0]
                        let location = placemark.location
                        let coords = location!.coordinate
                        print(location)
                        
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                        self.Map.setRegion(region, animated: true)
                        let ani = MKPointAnnotation()
                        ani.coordinate = placemark.location!.coordinate
                        ani.title = placemark.locality
                        ani.subtitle = placemark.subLocality
                        
                        self.Map.addAnnotation(ani)
                        
                        
                    }
            })
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        let searchQuery = searchBar.text! + " gym"
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = Map.region
        let s = MKLocalSearch(request: request)
        
        //remove old annotation
        let allAnnotations = self.Map.annotations
        self.Map.removeAnnotations(allAnnotations)
        
        s.start{response, _ in guard
            let response = response else{
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            
            for i in 1...matchingItems.count-1{
                let place = matchingItems[i].placemark
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.location!.coordinate
                annotation.title = place.name!
                annotation.subtitle = place.subLocality
                
                self.Map.addAnnotation(annotation)
            }
        }
    }
    
    //object of user class to call gym locator function
    var person:user =  user()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //show the user their current location
        showLocation()
    }
    
    
}

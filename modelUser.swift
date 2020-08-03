//
//  User.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

//model class that contains the methods that update user information
import UIKit
import MapKit
import Firebase
import FirebaseAuth

class user
{

    //variables
    var Map: MKMapView!
    
    var age:String!
    var weight:String!
    var height_feet:String!
    var height_inches:String!
    var workout:String!
    var weightGoal:String!
    var city:String!
    
    
    //workouts available to the user
    var strength:[String] = ["Chest & Triceps: Bench Press – 4x10 (Warm Up). Incline Bench Press – 4x10(Warm up). Decline Bench Press – 3x10(Warm up). Dumbbell Incline Flys – 4x8. Triceps Press down + Triceps Extension – 4x10. Dips – 4x10", "Legs(PUSH): Leg Extension – 4x10(Warmup). Back Squat – 2x10(Warmup). Lunges – 4x15. Leg Press – 4x10", "Back & Biceps: Lat Pull Downs – 4x10. Wide Grip Pull Ups + Dead Man Hang – 3x10. Straight Arm Pull down + Face Pull 4x15. Standing Barbell Curls – 4x10. Machine Preacher Curls – 4x10", "Leg(PULL)Lying Leg Curls - 4x10(Warmup). Deadlift – 4x5. Stiff Leg Deadlift – 3x10. Calves Rises – 4x25", "Shoulders & Traps: Standing Military Press – 3x1., Hang Cleans – 4x10. Barbell Shoulder Shrugs – 4x15. L – Shoulder Raises 4x10. Lat Pull Downs – 4x10.", "Rest day, workout if you want.", "Rest day, workout if you want."]
    
    var endurance:[String] = ["Chest & Triceps:Bench Press + Bench Dips- 4x12. Incline Press + Dumbbell flys     4x10. Decline Press     4x10. Elevated Push up(claps if possible)     3x12. Triceps Press down + Triceps Extensions     3x15. Skull Crushers + Dumbbell kickbacks     3x12.", "Legs(PUSH): Leg Extension(Warmup)    4x8-10. Squat + Box Jumps    4x10. Front Squats  + Lunges    3x12. Hanging Leg Lifts     4x12. Leg Press     3x15.", "Back & Biceps: Lat Pull Downs     3x12. Wide Grip Pull Ups + Dead Man Hang     3x10 30 second hang. Straight Arm Pull Down + Face Pull    4x10. Bent Over Biceps Curls + Row    3x15. Preacher Curls     4x10. Buddy Curls + Finger Curls     Countdown 15", "Legs(PULL): Lying Leg Curls     4x8-10    Pyramid Up. Deadlift 4x10-12. Calf Rise     4x30. Reverse Lunges     4x15. Seated Calf Rises + Step Ups     2x20 to failure.", "Shoulders & Traps: Standing Military Press    3x12. L - Raise     4x10. Shoulder Shrugs + Rack Pulls     3x10. Low cable face pull    3x10.", "Rest day, workout if you want.", "Rest day, workout if you want."]
    
    var cardio:[String] = ["20 min HIT: Stationary sprinters — 20 seconds, Boxer stance — 10 seconds, Squat thrust — 20 seconds, Boxer stance — 10 seconds, Spider-Man mountain climber — 20 seconds, Boxer stance — 10 seconds, Criss-cross pickup — 20 seconds, Boxer stance — 10 seconds, Power plank — 20 seconds, Boxer stance — 10 seconds, 20 Min Stair Climbers, 20 Min Elliptical, 1 Mile Sprint Training", "20 min HIT: Stationary sprinters — 20 seconds, Boxer stance — 10 seconds, Squat thrust — 20 seconds, Boxer stance — 10 seconds, Spider-Man mountain climber — 20 seconds, Boxer stance — 10 seconds, Criss-cross pickup — 20 seconds, Boxer stance — 10 seconds, Power plank — 20 seconds, Boxer stance — 10 seconds, 20 Min Stair Climbers, 20 Min Elliptical, 1 Mile Sprint Training", "20 min HIT: Stationary sprinters — 20 seconds, Boxer stance — 10 seconds, Squat thrust — 20 seconds, Boxer stance — 10 seconds, Spider-Man mountain climber — 20 seconds, Boxer stance — 10 seconds, Criss-cross pickup — 20 seconds, Boxer stance — 10 seconds, Power plank — 20 seconds, Boxer stance — 10 seconds, 20 Min Stair Climbers, 20 Min Elliptical, 1 Mile Sprint Training", "20 min HIT: Stationary sprinters — 20 seconds, Boxer stance — 10 seconds, Squat thrust — 20 seconds, Boxer stance — 10 seconds, Spider-Man mountain climber — 20 seconds, Boxer stance — 10 seconds, Criss-cross pickup — 20 seconds, Boxer stance — 10 seconds, Power plank — 20 seconds, Boxer stance — 10 seconds, 20 Min Stair Climbers, 20 Min Elliptical, 1 Mile Sprint Training", "20 min HIT: Stationary sprinters — 20 seconds, Boxer stance — 10 seconds, Squat thrust — 20 seconds, Boxer stance — 10 seconds, Spider-Man mountain climber — 20 seconds, Boxer stance — 10 seconds, Criss-cross pickup — 20 seconds, Boxer stance — 10 seconds, Power plank — 20 seconds, Boxer stance — 10 seconds, 20 Min Stair Climbers, 20 Min Elliptical, 1 Mile Sprint Training", "Rest day, workout if you want.", "Rest day, workout if you want."]
    var unsure:[String] = ["1 mile run. 50 push ups. 50 crunches.", "1 mile run. 50 push ups. 50 crunches.", "1 mile run. 50 push ups. 50 crunches.", "1 mile run. 50 push ups. 50 crunches.", "1 mile run. 50 push ups. 50 crunches.", "Rest day, workout if you want.", "Rest day, workout if you want."]
    
    //function that returns the workouts based on user selection
    func userWorkout(workout: String) -> [String]
    {
        var workoutPrefered = [String]()
        
        //fetch request to get the users prefered workout
        if(workout == "strength")
        {
        workoutPrefered = strength
        }
        if(workout == "endurance")
        {
            workoutPrefered = endurance
        }
        if(workout == "cardio")
        {
            workoutPrefered = cardio
        }
        if(workout == "noPref")
        {
            workoutPrefered = unsure
        }
        
        
        
        //return it
        return workoutPrefered
    }
    
    //function that populates the gym locator based on the users zipcode
    func findGym(Map1: MKMapView)
    {
        //set map
        Map = Map1
        
        //fetch request to get the users map preference
        
        //set the map view based on user preference
        Map.mapType = MKMapType.satellite
        
        //query for a gym
        let searchQuery = "Gym 85204"
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = Map.region
        let s = MKLocalSearch(request: request)
        
        //remove old annotation
        let allAnnotations = Map.annotations
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
    
    //function that checks settings input
    func saveSettings(age: UITextField, weight: UITextField, height_feet: UITextField, height_inches: UITextField, workouts: UISegmentedControl, weightGoal: UISegmentedControl, zip: UITextField, mapPreference: UISegmentedControl, error1: UILabel, error2: UILabel)
    {
        //check if fields are empty
        if(age.text! == "" || weight.text! == "" || zip.text! == "" || height_feet.text == "" || height_inches.text == "")
        {
            error1.isHidden = false
            error2.isHidden = false
            age.text = ""
            weight.text = ""
            height_feet.text = ""
            height_inches.text = ""
            zip.text = ""
            
        }
        else if (age.text!.isInt == false || weight.text!.isInt == false || zip.text!.isInt == false)
        {
            error1.isHidden = false
            error2.isHidden = false
            age.text = ""
            weight.text = ""
            height_feet.text = ""
            height_inches.text = ""
            zip.text = ""
        }
        else
        {
            //code to send all information and save user in firebase
            error1.isHidden = true
            error2.isHidden = true
        }
        
    }
    
    
}

class user2
{
        //create a constructor that takes a snapshot and extracts the values.
        init(snapshot:DataSnapshot)
        {
            let questionDictionary = snapshot.value as! [String:Any]
    
            age = questionDictionary["Age"] as! String
            weight = questionDictionary["Weight"] as! String
            height_feet = questionDictionary["height_feet"] as! String
            height_inches = questionDictionary["height_inches"] as! String
            workout = questionDictionary["workoutsLiked"] as! String
            weightGoal = questionDictionary["weight goal"] as! String
            city = questionDictionary["city"] as! String
            
        }
    var age:String!
    var weight:String!
    var height_feet:String!
    var height_inches:String!
    var workout:String!
    var weightGoal:String!
    var city:String!
}

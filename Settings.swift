//
//  Settings.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseDatabase

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

class settingsController: UIViewController
{
    //outlets
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height_feet: UITextField!
    @IBOutlet weak var height_inches: UITextField!
    @IBOutlet weak var workouts: UISegmentedControl!
    @IBOutlet weak var weightGoal: UISegmentedControl!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var mapPreference: UISegmentedControl!
    @IBOutlet weak var error1: UILabel!
    @IBOutlet weak var error2: UILabel!
    

    var username: String!
    var password: String!
    var saveFlag: Int!
    var workoutsLiked: String!
    
    //object of user class to call gym locator function
    //var person:user =  user()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        error1.isHidden = true
        error2.isHidden = true
    }
    @IBAction func feetSlider(_ sender: UISlider)
    {
        height_feet.text =  String(round(sender.value))
    }
    @IBAction func inchesSlider(_ sender: UISlider)
    {
        height_inches.text =  String(round(sender.value))
    }
    @IBAction func save(_ sender: Any)
    {
        if(workouts.selectedSegmentIndex == 0)
        {
            workoutsLiked = "strength"
        }
        if(workouts.selectedSegmentIndex == 1)
        {
            workoutsLiked = "endurance"
        }
        if(workouts.selectedSegmentIndex == 2)
        {
            workoutsLiked = "cardio"
        }
        if(workouts.selectedSegmentIndex == 3)
        {
            workoutsLiked = "noPref"
        }
        
        let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
        let values = ["Age": "0", "Weight": "0", "height_inches": "0", "height_feet": "0", "workoutsLiked": workoutsLiked, "weight goal": "lose", "city": zip.text!]
        ref.setValue(values)
        
        //segue to view
        self.performSegue(withIdentifier: "toHome2", sender: sender)
        
        
    }
    
    
}

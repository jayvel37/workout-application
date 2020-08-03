//
//  Workouts.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseDatabase


class workoutsController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //object of user class to call gym locator function
    var person:user =  user()
    
    //empty array that will catch the workout the user selects.
    var workout = [String]()
    
    //day of the week for table view cell
    var day:[String] = ["Monday workout", "Tuesday workout", "Wednesday workout", "Thursday workout", "Friday workout", "Saturday", "Sunday"]
    
    
    //sets the number of rows for the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
    }
    
    //sets up the rows and labels them with days of the week
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        //set the text for the days of the week
        cell.textLabel?.text = day[indexPath.row]
        return cell
    }
    
    //function to get you to the detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var workoutLiked2:String!
        let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
        
        //get snapshot of model
        ref.observe(.value, with: { snapshot in
            let dict = snapshot.value as? [String:Any]
            
            workoutLiked2 = dict!["workoutsLiked"] as? String
            
            //get the workout
            self.workout = self.person.userWorkout(workout: workoutLiked2)
            
            //send info to detail view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "1") as! DetailViewController
            
            detailViewController.getWorkout = self.workout[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        })
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logout(_ sender: Any)
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: "logout", sender: self)
    }
    
}

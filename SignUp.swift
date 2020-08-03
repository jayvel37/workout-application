//
//  SignUp.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpController: UIViewController
{
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var verifyPasswordField: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var segueButton: UIButton!
    
    //object of user class to call model functions
    var person:user =  user()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //emailError.isHidden = true
        passwordError.isHidden = true
        segueButton.isHidden = true
        
        //notify user that passwor must be 6 characters or more
        //notify user of error via text field
        let alert = UIAlertController(title: "Password must be 6 or more characters or your account will not be created.", message: nil, preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        {
            (action) in
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func `continue`(_ sender: Any)
    {
        
        //check if passwords match
        if(passwordField.text == "" || verifyPasswordField.text == "")
        {
            //do nothing
        }
        else if(passwordField.text == verifyPasswordField.text)
        {
            
            //Create the user with the e-mail and password.
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
                (user,error) in
                if (user != nil)
                {
                    //success create dummy field values
                    let ref = Database.database().reference(fromURL: "https://fitnessbuddy2-4fc06.firebaseio.com/")
                    let values = ["Age": "0", "Weight": "0", "height_inches": "0", "height_feet": "0", "workoutsLiked": "unsure", "weight goal": "lose", "city": "mesa"]
                    let userReference = ref.child("Users").child((Auth.auth().currentUser?.uid)!)
                    userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                        if err != nil
                        {
                            print(err)
                            return
                        }
                        print("")
                    })
                    self.performSegue(withIdentifier: "toSettings", sender: self)
                    
                }
                else
                {
                    //do nothing
                    let alert = UIAlertController(title: "Password must be 6 or more characters or more.", message: nil, preferredStyle: .alert)
                    
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    {
                        (action) in
                    }
                    
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: true)
                }
            })
            
        }
        else
        {
            passwordField.text = ""
            verifyPasswordField.text = ""
        }
        
    }
    
    
}



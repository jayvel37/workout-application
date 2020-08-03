//
//  Login.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit

import Firebase

class LoginController: UIViewController
{
    //object of user class to call model functions
    var person:user =  user()
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        error.isHidden = true
    }
    @IBAction func login(_ sender: Any)
    {
        //log user in with firebase
        //person.loginFirebaseUser(email: email, password: password, error: error)
        
        //Create the user with the e-mail and password.
        Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: {
            (user,error) in
            if (user != nil)
            {
                //success
                //self.Fire.AddProfile(S:self)
                //segue to view
                self.performSegue(withIdentifier: "toHomePage", sender: sender)
            }
            else
            {
                self.email.text = ""
                self.password.text = ""
                self.error.isHidden = false

            }
        })
    }
    
    
}

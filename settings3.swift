//
//  settings2.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/15/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class settings3Controller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    let picker = UIImagePickerController()
    var workoutsLiked:String!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var workouts: UISegmentedControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
    }
    @IBAction func save(_ sender: Any)
    {
        if(zip.text! == "")
        {
            let alert = UIAlertController(title: "try again", message: nil, preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            {
                (action) in
            }
            
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        else
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
            
            let alert = UIAlertController(title: "saved", message: nil, preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            {
                (action) in
            }
            
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func addPic(_ sender: Any)
    {
        //get profile picture
        let alert = UIAlertController(title: "Enter photo for profile", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Library photo", style: .default, handler: { action in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                self.picker.allowsEditing = false
                self.picker.sourceType = .camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                print("no camera")
            }
            
        }))
        
        self.present(alert, animated: true)
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        picker .dismiss(animated: true, completion: nil)
        //         self.performSegue(withIdentifier: "toSettings", sender: self)
        //        imageSelected.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

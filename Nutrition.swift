//
//  Nutrition.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation

import UIKit

class nutritionController: UIViewController
{

    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var results: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func calculate(_ sender: Any)
    {
        //check if the text field is empty
        if(foodName.text! == "")
        {
            //notify user of error via text field
            let alert = UIAlertController(title: "Field was not filled in", message: nil, preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            {
                (action) in
            }
            
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        else
        {
            let request = "https://api.edamam.com/api/nutrition-data?app_id=ad40ed37&app_key=446a6a991fa90b85cf6d4cc248c6138c&ingr=1%20large%20"+foodName.text!
            
            
            let url = URL(string: request)!
            print(url)
            
            
            let urlSession = URLSession.shared
            
            
            let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                if (error != nil) {
                    print(error!.localizedDescription)
                }
                var err: NSError?
                
                
                var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                if (err != nil) {
                    
                    //clear fields
                    self.foodName.text = ""
                    
                    
                    //notify user of error via text field
                    let alert = UIAlertController(title: "An error occured please try again.", message: nil, preferredStyle: .alert)
                    
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    {
                        (action) in
                    }
                    
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: true)
                    
                    print("JSON Error \(err!.localizedDescription)")
                }
                
                //results.text = jsonResult
                print(jsonResult)
                
                let setOne = jsonResult["calories"]! as! NSInteger
                
                DispatchQueue.main.async
                    {
                var calories:Int = Int(setOne)
                

                self.results.text = "Calories for this food is: "+String(calories)
            }
                
            })
            
            jsonQuery.resume()
            
        }
        }
        
}

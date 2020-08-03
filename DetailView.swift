//
//  DetailView.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController
{
    var getWorkout = String()
    @IBOutlet weak var workoutsLiked: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        workoutsLiked.text! = getWorkout
    }
    
    
}

//
//  ViewController.swift
//  FitnessBuddy2.0
//
//  Created by Jay Velazco on 4/13/19.
//  Copyright © 2019 Jay Velazco. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var Backgorund: UIImageView!
    @IBOutlet weak var upper: UIImageView!
    @IBOutlet weak var lower: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Backgorund.image = UIImage(named: "white.png")
        upper.image = UIImage(named: "pushup.jpeg")
        lower.image = UIImage(named: "rope.jpeg")
    }


}


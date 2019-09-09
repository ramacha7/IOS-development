//
//  ViewController.swift
//  Magic 8 ball
//
//  Created by vignesh ramachandran on 6/26/19.
//  Copyright © 2019 vignesh ramachandran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let array = ["ball1", "ball2", "ball3", "ball4"]
    @IBOutlet weak var ballprediction: UIImageView!
    
    var prediction = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        operation()
    }

    @IBAction func predict(_ sender: Any) {
        operation()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        operation()
    }
    
    func operation(){
        
        prediction = Int.random(in: 0 ... 3)
        
        ballprediction.image = UIImage(named: array[prediction])
    }
}


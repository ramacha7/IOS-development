//
//  ViewController.swift
//  Dicee game
//
//  Created by vignesh ramachandran on 6/26/19.
//  Copyright © 2019 vignesh ramachandran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let array = ["dice1","dice2", "dice3", "dice4", "dice5", "dice6"]

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var random1 = 0
    var random2 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        operation()
    }

    @IBAction func Rollbutton(_ sender: UIButton) {

        operation()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        operation()
    }
    func operation(){
        random1 = Int.random(in: 0 ... 5)
        random2 = Int.random(in: 0 ... 5)
        
        diceImageView1.image = UIImage(named: array[random1])
        diceImageView2.image = UIImage(named: array[random2])
    }
}


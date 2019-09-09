//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var player = AVAudioPlayer()
    let sound = ["note1","note2","note3","note4","note5","note6","note7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        let note = sound[sender.tag-1]
        playsound(whichnote : note)
        
    }
  
    func playsound(whichnote : String)
    {
        let site = Bundle.main.url(forResource: whichnote, withExtension: "wav")
        do
        {
            try player = AVAudioPlayer(contentsOf: site!)
            
        }
        catch{
            print(error)
        }
        player.play()
    }

}


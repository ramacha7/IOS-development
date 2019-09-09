//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    var QUESTIONS = QuestionBank()
    var pickedanswer : Bool = false
    var questionnumber = 0
    var score = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        scoreLabel.text = "YOUR SCORE :\(0)"
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if(sender.tag == 1)
        {
            pickedanswer = true
        }
        else{
            pickedanswer = false
        }
        
        checkAnswer()
        
        questionnumber += 1
        
        nextQuestion()
  
    }
    
    
    func updateUI() {
        scoreLabel.text = "YOUR SCORE : \(score)"
        progressLabel.text = "\(questionnumber+1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(13)) * CGFloat(questionnumber+1)
      
    }
    

    func nextQuestion() {
        if(questionnumber <= 12)
        {
            let Question = QUESTIONS.list[questionnumber].questionText
            questionLabel.text = Question
            updateUI()
        }
        else
        {
            scoreLabel.text = "YOUR SCORE : \(score)"
            let alert = UIAlertController(title: "Awesome!!", message: "Do you want to go again??", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default)
            { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restart)
            
            present(alert,animated: true,completion: nil)
            
        }
        
        
    }
    
    
    func checkAnswer() {
        let correctanswer = QUESTIONS.list[questionnumber].answer
        
        if(correctanswer == pickedanswer)
        {
            ProgressHUD.showSuccess("Correct !!")
            score += 1
        }
        else
        {
            ProgressHUD.showError("Wrong !!")
            
        }
        
        
    }
    
    
    func startOver() {
        questionnumber = 0
        score = 0
        nextQuestion()
        
       
    }
    

    
}

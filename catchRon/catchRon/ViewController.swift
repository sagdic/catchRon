//
//  ViewController.swift
//  catchRon
//
//  Created by tayfun on 8.11.2021.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var ronArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ron1: UIImageView!
    @IBOutlet weak var ron2: UIImageView!
    @IBOutlet weak var ron3: UIImageView!
    @IBOutlet weak var ron9: UIImageView!
    @IBOutlet weak var ron8: UIImageView!
    @IBOutlet weak var ron7: UIImageView!
    @IBOutlet weak var ron6: UIImageView!
    @IBOutlet weak var ron5: UIImageView!
    @IBOutlet weak var ron4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        //images
        
        ron1.isUserInteractionEnabled = true
        ron2.isUserInteractionEnabled = true
        ron3.isUserInteractionEnabled = true
        ron4.isUserInteractionEnabled = true
        ron5.isUserInteractionEnabled = true
        ron6.isUserInteractionEnabled = true
        ron7.isUserInteractionEnabled = true
        ron8.isUserInteractionEnabled = true
        ron9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        ron1.addGestureRecognizer(recognizer1)
        ron2.addGestureRecognizer(recognizer2)
        ron3.addGestureRecognizer(recognizer3)
        ron4.addGestureRecognizer(recognizer4)
        ron5.addGestureRecognizer(recognizer5)
        ron6.addGestureRecognizer(recognizer6)
        ron7.addGestureRecognizer(recognizer7)
        ron8.addGestureRecognizer(recognizer8)
        ron9.addGestureRecognizer(recognizer9)
        
        ronArray = [ron1, ron2, ron3, ron4, ron5, ron6, ron7, ron8, ron9]
        
        //Timers
        counter = 15
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideRon), userInfo: nil, repeats: true)
        
        hideRon()
        
    }
    
    @objc func hideRon(){
        for ron in ronArray{
            ron.isHidden = true        }
        
        let random = Int(arc4random_uniform(UInt32(ronArray.count-1)))
        ronArray[random].isHidden=false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for ron in ronArray {
                ron.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideRon), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }


}


}

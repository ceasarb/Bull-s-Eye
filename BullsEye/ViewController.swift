//
//  ViewController.swift
//  BullsEye
//
//  Created by Ceasar Barbosa on 5/17/16.
//  Copyright © 2016 Ceasar Barbosa. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSlider()
        
        self.startNewGame()
        self.updateLabels()
    
    }

    
    // This shows alert when Hit Me button is pressed
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "So close!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not even close..."
        }
        
        score += points

        
        // Alert Message
        let message = "Your shot was: \(currentValue)" +
                        "\nYou scored \(points) points"
        
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok",
                                   style: .Default,
                                   handler: { action in
                                               self.startNewRound()  // start new round and update labels,
                                               self.updateLabels()   // AFTER alert message dismissed
                                            })
        
        alert.addAction(action)
        
        // Present the alert controller
        presentViewController(alert,
                              animated: true,
                              completion: nil)
        
    }
    
    // Function grabs the slider value
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOverButtonTapped(button: UIButton) {
        self.startNewGame()
        self.updateLabels()
        
    }
    
    func startNewGame() {
        score = 0
        round = 0
        self.startNewRound()
        self.animation()
        
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)

    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        
    }
    
    func configureSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackResizable, forState: .Normal)
            
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackResizable, forState: .Normal)
        }
    }
    
    func animation() {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }
    


}


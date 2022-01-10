//
//  ViewController.swift
//  EggTimer
//
//  Created by Evgenii Lysenko on 1/9/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var audioPlayer: AVAudioPlayer!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()

    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()  // - stop timer
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]! // - total time depend of which button was pressed
        
        progressBar.progress = 0.0 // - reset a progress bar
        secondsPassed = 0 // - reset a secondPassed
        doneLabel.text = hardness // - change the label depends of wich button was pressed
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true) // - start timer
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
    }
    
    //Function for updatimg counter depend of which button was pressed
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            doneLabel.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
    }
}


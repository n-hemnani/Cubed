//
//  TimerViewController.swift
//  Cubed
//
//  Created by iD Student on 7/14/16.
//  Copyright © 2016 iD Tech. All rights reserved.
//

import UIKit
import QuartzCore
let defaults = NSUserDefaults.standardUserDefaults()
var times = defaults.objectForKey("timesArray") as? [Double] ?? [Double]()

class TimerViewController: UIViewController
{
    @IBOutlet weak var scrambleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var solvesLabel: UILabel!
    
    var timer: NSTimer? = NSTimer()
    var startTime = NSTimeInterval()
    var elapsedTime: NSTimeInterval = 0.0
    var timerOn: Bool = false
    
    var scrambleLetter: [String] = ["F", "B", "U", "D", "R", "L"]
    var scrambleModifiers: [String] = ["'", "2", ""]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        scrambleLabel.text = generateScramble()
        scrambleLabel.numberOfLines = 0
        scrambleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        solvesLabel.text = "solves: \(times.count)"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if timerOn == false
        {
            let aSelector : Selector = #selector(TimerViewController.updateTime)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            timerOn = true
        }
        else
        {
            timer!.invalidate()
            timer = nil
            timerOn = false
            
            let seconds = UInt8(elapsedTime)
            elapsedTime -= NSTimeInterval(seconds)
            let fraction = UInt8(elapsedTime * 100)
            let strSeconds = String(format: "%02d", seconds)
            let strFraction = String(format: "%02d", fraction)
            times.append(Double("\(strSeconds).\(strFraction)")!)
            defaults.setObject(times, forKey: "timesArray")
            
            scrambleLabel.text = generateScramble()
            solvesLabel.text = "solves: \(times.count)"
        }
    }
    
    /*
     SCRAMBLE THE 3X3X3 RUBIK'S CUBE
    */
    func chooseScrambleLetter() -> Int
    {
        let chooseScrambleLetter = Int(arc4random_uniform(UInt32(6)))
        return chooseScrambleLetter
    }
    
    func chooseScrambleModifier() -> Int
    {
        let chooseScrambleModifier = Int(arc4random_uniform(UInt32(3)))
        return chooseScrambleModifier
    }
    
    func generateScramble() -> String
    {
        var fullScrambleString = ""
        var currentLetter = "f"
        var previousLetter = "f"
        var letterBeforePrevious = "f"
        
        var letterBeforePreviousCharacter = letterBeforePrevious[letterBeforePrevious.startIndex]
        var previousLetterCharacter = previousLetter[previousLetter.startIndex]
        var currentLetterCharacter = currentLetter[currentLetter.startIndex]
        
        for var i = 1; i <= 25; i += 1
        {
            letterBeforePreviousCharacter = letterBeforePrevious[letterBeforePrevious.startIndex]
            previousLetterCharacter = previousLetter[previousLetter.startIndex]
            currentLetterCharacter = currentLetter[currentLetter.startIndex]
            
            repeat
            {
                currentLetter = scrambleLetter[chooseScrambleLetter()]
                currentLetterCharacter = currentLetter[currentLetter.startIndex]
            } while currentLetterCharacter == previousLetterCharacter || currentLetterCharacter == letterBeforePreviousCharacter
            
            currentLetter = currentLetter + scrambleModifiers[chooseScrambleModifier()]
            fullScrambleString = fullScrambleString + currentLetter + " "
            
            letterBeforePrevious = previousLetter
            previousLetter = currentLetter
            
        }
        return fullScrambleString
    }
    /*
     SCRAMBLE THE 3X3X3 RUBIK'S CUBE
     */
    
    /*
     USE THE TIMER
    */
    func updateTime()
    {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        elapsedTime = currentTime - startTime
        var displayElapsedTime: NSTimeInterval = currentTime - startTime
        
        let seconds = UInt8(displayElapsedTime)
        displayElapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(displayElapsedTime * 100)
        
        let strSeconds = String(format: "%01d", seconds)
        let strFraction = String(format: "%02d", fraction)
        timerLabel.text = "\(strSeconds).\(strFraction)"
        
    }
    /*
     USE THE TIMER
    */
}











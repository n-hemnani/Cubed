//
//  StatisticsViewContoller.swift
//  Cubed
//
//  Created by iD Student on 7/14/16.
//  Copyright © 2016 iD Tech. All rights reserved.
//

import UIKit

var maximum = times[0]
var minimum = times[0]

class StatisticsViewContoller: UIViewController
{
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var worstTimeLabel: UILabel!
    @IBOutlet weak var currentMean3Label: UILabel!
    @IBOutlet weak var bestMean3Label: UILabel!
    @IBOutlet weak var currentAverage5Label: UILabel!
    @IBOutlet weak var bestAverage5Label: UILabel!
    @IBOutlet weak var currentAverage12Label: UILabel!
    @IBOutlet weak var bestAverage12Label: UILabel!
    @IBOutlet weak var currentAverage100Label: UILabel!
    @IBOutlet weak var bestAverage100Label: UILabel!
    @IBOutlet weak var sessionAverageLabel: UILabel!
    
    @IBAction func resetTimesButton(sender: AnyObject) {
        times.removeAll()
        bestTimeLabel.text = "best time: N/A"
        worstTimeLabel.text = "worst time: N/A"
        currentMean3Label.text = "current mo3: N/A"
        bestMean3Label.text = "best mo3: N/A"
        currentAverage5Label.text = "current ao5: N/A"
        bestAverage5Label.text = "best ao5: N/A"
        currentAverage12Label.text = "current ao12: N/A"
        bestAverage12Label.text = "best ao12: N/A"
        currentAverage100Label.text = "current ao100: N/A"
        bestAverage100Label.text = "best ao100: N/A"
        sessionAverageLabel.text = "session mean: N/A"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        findWorstAndBestTime()
        findCurrentAndBestMean3()
        findCurrentAndBestAverage5()
        findCurrentAndBestAverage12()
        findCurrentAndBestAverage100()
        findSessionMean()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(true)
        
        findWorstAndBestTime()
        findCurrentAndBestMean3()
        findCurrentAndBestAverage5()
        findCurrentAndBestAverage12()
        findCurrentAndBestAverage100()
        findSessionMean()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findWorstAndBestTime()
    {
        if times.count < 1
        {
            worstTimeLabel.text = "worst time: N/A"
            bestTimeLabel.text = "best time: N/A"
        }
        else
        {
            maximum = times.maxElement()!
            minimum = times.minElement()!
            
            var seconds = UInt8(maximum)
            maximum -= NSTimeInterval(seconds)
            var fraction = UInt8(maximum * 100)
            var strSeconds = String(format: "%01d", seconds)
            var strFraction = String(format: "%02d", fraction)
            
            worstTimeLabel.text = "worst time: \(strSeconds).\(strFraction)"
            
            seconds = UInt8(minimum)
            minimum -= NSTimeInterval(seconds)
            fraction = UInt8(minimum * 100)
            strSeconds = String(format: "%01d", seconds)
            strFraction = String(format: "%02d", fraction)
            
            bestTimeLabel.text = "best time: \(strSeconds).\(strFraction)"
        }
    }
    
    func findCurrentAndBestMean3()
    {
        if times.count < 3
        {
            currentMean3Label.text = "current mo3: N/A"
            bestMean3Label.text = "best mo3: N/A"
        }
        else
        {
            var bestMean3 = (times[0] + times[1] + times[2]) / 3
            var currentMean3 = (times[(times.count) - 1] + times[(times.count) - 2] + times[(times.count) - 3]) / 3
            
            for var i = 0; i < times.count - 3; i += 1
            {
                if (times[i] + times[i + 1] + times[i + 2]) / 3 < bestMean3
                {
                    bestMean3 = (times[i] + times[i + 1] + times[i + 2]) / 3
                }
            }
            
            var seconds = UInt8(bestMean3)
            bestMean3 -= NSTimeInterval(seconds)
            var fraction = UInt8(bestMean3 * 100)
            var strSeconds = String(format: "%01d", seconds)
            var strFraction = String(format: "%02d", fraction)
            
            bestMean3Label.text = "best mo3: \(strSeconds).\(strFraction)"
            
            seconds = UInt8(currentMean3)
            currentMean3 -= NSTimeInterval(seconds)
            fraction = UInt8(currentMean3 * 100)
            strSeconds = String(format: "%01d", seconds)
            strFraction = String(format: "%02d", fraction)
            
            currentMean3Label.text = "current mo3: \(strSeconds).\(strFraction)"
        }
    }
    
    func findCurrentAndBestAverage5()
    {
        if times.count < 5
        {
            currentAverage5Label.text = "current ao5: N/A"
            bestAverage5Label.text = "best ao5: N/A"
        }
        else
        {
            let indexingVariable = 5
            var currentAverage5: Double = 0.0
            var bestAverage5: Double = 1000.0
            
            for var i = 0; i <= times.count - indexingVariable; i += 1
            {
                for var j = i; j < i + indexingVariable; j += 1
                {
                    var averageOfFive: [Double] = [times[i], times[i + 1], times[i + 2], times[i + 3], times[i + 4]]
                    
                    averageOfFive.removeAtIndex(averageOfFive.indexOf(averageOfFive.maxElement()!)!)
                    averageOfFive.removeAtIndex(averageOfFive.indexOf(averageOfFive.minElement()!)!)
                    
                    currentAverage5 = (averageOfFive[0] + averageOfFive[1] + averageOfFive[2]) / 3
                    
                    if currentAverage5 < bestAverage5
                    {
                        bestAverage5 = currentAverage5
                    }
                }
            }
            
            var seconds = UInt8(bestAverage5)
            bestAverage5 -= NSTimeInterval(seconds)
            var fraction = UInt8(bestAverage5 * 100)
            var strSeconds = String(format: "%01d", seconds)
            var strFraction = String(format: "%02d", fraction)
            
            bestAverage5Label.text = "best ao5: \(strSeconds).\(strFraction)"
            
            var mostRecentAverage5Array: [Double] = [times[(times.count) - 1], times[(times.count) - 2], times[(times.count) - 3], times[(times.count) - 4], times[(times.count) - 5]]
            mostRecentAverage5Array.removeAtIndex(mostRecentAverage5Array.indexOf(mostRecentAverage5Array.maxElement()!)!)
            mostRecentAverage5Array.removeAtIndex(mostRecentAverage5Array.indexOf(mostRecentAverage5Array.minElement()!)!)
            
            var mostRecentAverage5 = (mostRecentAverage5Array[0] + mostRecentAverage5Array[1] + mostRecentAverage5Array[2]) / 3
            
            seconds = UInt8(mostRecentAverage5)
            mostRecentAverage5 -= NSTimeInterval(seconds)
            fraction = UInt8(mostRecentAverage5 * 100)
            strSeconds = String(format: "%01d", seconds)
            strFraction = String(format: "%02d", fraction)
            
            currentAverage5Label.text = "current ao5: \(strSeconds).\(strFraction)"
        }
    }
    
    func findCurrentAndBestAverage12()
    {
        if times.count < 12 {
            bestAverage12Label.text = "best ao12: N/A"
            currentAverage12Label.text = "current ao12: N/A"
        }
        else
        {
            let indexingVariable = 12
            var currentAverageOf12: Double = 0.0
            var bestAverage12: Double = 1000.0
            
            for var i = 0; i <= times.count - indexingVariable; i += 1
            {
                for var j = i; j < i + indexingVariable; j += 1
                {
                    var averageOfTwelve: [Double] = []
                    
                    for var k = i; k < i + indexingVariable; k++
                    {
                        averageOfTwelve.append(times[k])
                    }
                    
                    averageOfTwelve.removeAtIndex(averageOfTwelve.indexOf(averageOfTwelve.maxElement()!)!)
                    averageOfTwelve.removeAtIndex(averageOfTwelve.indexOf(averageOfTwelve.minElement()!)!)
                    
                    var averageOfTwelveSum: Double = 0.0
                    for var l = 0; l < 10; l++
                    {
                        averageOfTwelveSum += averageOfTwelve[l]
                    }
                    
                    currentAverageOf12 = averageOfTwelveSum / 10
                    
                    if currentAverageOf12 < bestAverage12
                    {
                        bestAverage12 = currentAverageOf12
                    }
                }
            }
            
            var seconds = UInt8(bestAverage12)
            bestAverage12 -= NSTimeInterval(seconds)
            var fraction = UInt8(bestAverage12 * 100)
            var strSeconds = String(format: "%01d", seconds)
            var strFraction = String(format: "%02d", fraction)
            
            bestAverage12Label.text = "best ao12: \(strSeconds).\(strFraction)"
            
            var mostRecentAverage12Array: [Double] = []
            
            for var i = 1; i <= 12; i++
            {
                mostRecentAverage12Array.append(times[(times.count) - i])
            }
            
            mostRecentAverage12Array.removeAtIndex(mostRecentAverage12Array.indexOf(mostRecentAverage12Array.maxElement()!)!)
            mostRecentAverage12Array.removeAtIndex(mostRecentAverage12Array.indexOf(mostRecentAverage12Array.minElement()!)!)
            
            var mostRecentAverage12: Double = 0.0
            for var i = 0; i < 10; i++
            {
                mostRecentAverage12 += mostRecentAverage12Array[i]
            }
            mostRecentAverage12 = mostRecentAverage12 / 10
            
            seconds = UInt8(mostRecentAverage12)
            mostRecentAverage12 -= NSTimeInterval(seconds)
            fraction = UInt8(mostRecentAverage12 * 100)
            strSeconds = String(format: "%01d", seconds)
            strFraction = String(format: "%02d", fraction)
            
            currentAverage12Label.text = "current ao12: \(strSeconds).\(strFraction)"
        }
    }
    
    func findCurrentAndBestAverage100()
    {
        if times.count < 100 {
            bestAverage100Label.text = "best ao100: N/A"
            currentAverage100Label.text = "current ao100: N/A"
        }
        else
        {
            let indexingVariable = 100
            var currentAverageOf100: Double = 0.0
            var bestAverage100: Double = 1000.0
            
            for var i = 0; i <= times.count - indexingVariable; i += 1
            {
                for var j = i; j < i + indexingVariable; j += 1
                {
                    var averageOfHundred: [Double] = []
                    
                    for var k = i; k < i + indexingVariable; k++
                    {
                        averageOfHundred.append(times[k])
                    }
                    
                    for var k = 0; k < 5; k++
                    {
                        averageOfHundred.removeAtIndex(averageOfHundred.indexOf(averageOfHundred.maxElement()!)!)
                        averageOfHundred.removeAtIndex(averageOfHundred.indexOf(averageOfHundred.minElement()!)!)
                    }
                    
                    var averageOfHundredSum: Double = 0.0
                    for var l = 0; l < 90; l++
                    {
                        averageOfHundredSum += averageOfHundred[l]
                    }
                    
                    currentAverageOf100 = averageOfHundredSum / 90
                    
                    if currentAverageOf100 < bestAverage100
                    {
                        bestAverage100 = currentAverageOf100
                    }
                }
            }
            
            var seconds = UInt8(bestAverage100)
            bestAverage100 -= NSTimeInterval(seconds)
            var fraction = UInt8(bestAverage100 * 100)
            var strSeconds = String(format: "%01d", seconds)
            var strFraction = String(format: "%02d", fraction)
            
            bestAverage100Label.text = "best ao100: \(strSeconds).\(strFraction)"
            
            var mostRecentAverage100Array: [Double] = []
            
            for var i = 1; i <= 100; i++
            {
                mostRecentAverage100Array.append(times[(times.count) - i])
            }
            
            for var i = 0; i < 5; i++
            {
                mostRecentAverage100Array.removeAtIndex(mostRecentAverage100Array.indexOf(mostRecentAverage100Array.maxElement()!)!)
                mostRecentAverage100Array.removeAtIndex(mostRecentAverage100Array.indexOf(mostRecentAverage100Array.minElement()!)!)
            }
            
            var mostRecentAverage100: Double = 0.0
            for var i = 0; i < 90; i++
            {
                mostRecentAverage100 += mostRecentAverage100Array[i]
            }
            
            mostRecentAverage100 = mostRecentAverage100 / 90
            
            seconds = UInt8(mostRecentAverage100)
            mostRecentAverage100 -= NSTimeInterval(seconds)
            fraction = UInt8(mostRecentAverage100 * 100)
            strSeconds = String(format: "%01d", seconds)
            strFraction = String(format: "%02d", fraction)
            
            currentAverage100Label.text = "current ao100: \(strSeconds).\(strFraction)"
        }
    }
    
    
    func findSessionMean()
    {
        if times.count < 1
        {
            sessionAverageLabel.text = "session mean: N/A"
        }
        else
        {
            var sessionAverageSum: Double = 0.0
            for var i = 0; i < times.count; i++
            {
                sessionAverageSum += times[i]
            }
            
            var sessionMean = sessionAverageSum / Double(times.count)
            
            let seconds = UInt8(sessionMean)
            sessionMean -= NSTimeInterval(seconds)
            var fraction = UInt8(sessionMean * 100)
            let strSeconds = String(format: "%01d", seconds)
            let strFraction = String(format: "%02d", fraction)
            
            sessionAverageLabel.text = "session mean: \(strSeconds).\(strFraction)"
        }
    }
}

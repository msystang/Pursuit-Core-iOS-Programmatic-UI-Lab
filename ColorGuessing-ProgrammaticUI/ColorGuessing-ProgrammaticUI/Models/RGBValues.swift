//
//  RGBValues.swift
//  ColorGuessing-ProgrammaticUI
//
//  Created by Sunni Tang on 10/10/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit
import Foundation

struct RGBValues {
    var randomColor: UIColor
    var dominantColor: UIColor
    var currentScore: Int = 0

    
    init() {
        let someRandomColor = RGBValues.getRandomColor()
        self.randomColor = someRandomColor.randomColor
        self.dominantColor = someRandomColor.dominantColor
    }
    
    mutating func assignNewColor() {
        let someRandomColor = RGBValues.getRandomColor()
        self.randomColor = someRandomColor.randomColor
        self.dominantColor = someRandomColor.dominantColor
    }
    
    static func getRandomColor() -> (randomColor: UIColor, dominantColor: UIColor) {
        //Gets random values for R, G, B
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        //Get highest value between R, G, B
        let highestColorValue = max(redValue, greenValue, blueValue)
        
        //Assign dominant color based on highest R, G, B value
        let dominantColor: UIColor
        if highestColorValue == redValue {
            dominantColor = UIColor.red
        } else if highestColorValue == greenValue{
            dominantColor = UIColor.green
        } else{
            dominantColor = UIColor.blue
        }
        
        return (randomColor, dominantColor)
    }
    
    
    mutating func checkGuess(_ userGuess: UIColor) -> Bool {
        if userGuess == dominantColor {
            self.currentScore += 1
            return true
        } else {
            return false
        }
    }
    
}


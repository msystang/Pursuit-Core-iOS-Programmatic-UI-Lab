//
//  ViewController.swift
//  ColorGuessing-ProgrammaticUI
//
//  Created by Sunni Tang on 10/10/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Lazy Variables
    lazy var highScoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var currentScoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var colorBoard: UIView = {
        let colorboard = UIView()
        return colorboard
    }()
    
    lazy var gameOverLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - UI Lazy Variables & Actions
    lazy var redButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(makeGuess(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var greenButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.green, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(makeGuess(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(makeGuess(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var newGameButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startNewGame(button:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Internal Properties
    var highScoreValue = 0
    var currentColor = RGBValues.init()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.colorBoard.backgroundColor = currentColor.randomColor
        hideGOButtons()
        
    }
    
    // MARK: - UI OBJC Functions
    @objc func makeGuess(button: UIButton) {
        var userGuess: UIColor

        switch button.tag {
            case 0:
                userGuess = UIColor.red
            case 1:
                userGuess = UIColor.green
            case 2:
                userGuess = UIColor.blue
            default:
                userGuess = UIColor.black
        }
        
        let answer = currentColor.checkGuess(userGuess)
        if answer {
            self.currentScoreLabel.text = "Current Score: \(currentColor.currentScore)"

            resetRandomColor()
        } else {
            disableButtons()
            self.gameOverLabel.isHidden = false
            self.newGameButton.isHidden = false
        }
    }
    
    
    @objc func startNewGame(button: UIButton) {
        
        //assign high score
        if highScoreValue < currentColor.currentScore {
            highScoreValue = currentColor.currentScore
        }
        self.highScoreLabel.text = "High Score: \(highScoreValue)"
        
        //reset counter
        self.currentScoreLabel.text = "Current Score: 0"
        self.currentColor.currentScore = 0
        
        //reset random color
        resetRandomColor()
        
        //enable buttons
        self.redButton.isEnabled = true
        self.greenButton.isEnabled = true
        self.blueButton.isEnabled = true
        
        //hide game over buttons
        hideGOButtons()
    }
    
    
    private func resetRandomColor() {
        self.currentColor.assignNewColor()
        self.colorBoard.backgroundColor = currentColor.randomColor
    }
    
    
    private func disableButtons() {
        self.redButton.isEnabled = false
        self.greenButton.isEnabled = false
        self.blueButton.isEnabled = false
    }
    
    
    private func hideGOButtons() {
        self.gameOverLabel.isHidden = true
        self.newGameButton.isHidden = true
    }



}


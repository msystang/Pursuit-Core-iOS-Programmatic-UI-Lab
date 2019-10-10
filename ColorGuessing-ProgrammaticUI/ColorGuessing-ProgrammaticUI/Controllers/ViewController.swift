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
        label.text = "High Score: 0"
        return label
    }()
    
    lazy var currentScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Score: 0"
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
        button.setTitle("Red", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(makeGuess(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var greenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Green", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(makeGuess(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Blue", for: .normal)
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
        
        configureColorBoard()
        configureLabelStackView()
        configureColorButtonStackView()
        
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
    
    // MARK: - Private Methods
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

    // MARK: - UI Constraint Methods
    private func configureColorBoard() {
        view.addSubview(colorBoard)
        colorBoard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            colorBoard.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            colorBoard.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureLabelStackView() {
        let stackView = UIStackView(arrangedSubviews: [highScoreLabel, currentScoreLabel])
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: colorBoard.topAnchor, constant: 10)
            
        ])
    }
    
    
    private func configureColorButtonStackView() {
        let stackView = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton])
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            stackView.topAnchor.constraint(equalTo: colorBoard.bottomAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5)
        ])
    }
    
    private func configureNewGameButton() {
        view.addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
        
    }
    
    

}


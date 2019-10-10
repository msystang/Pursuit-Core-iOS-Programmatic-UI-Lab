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
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


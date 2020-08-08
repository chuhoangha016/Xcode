//
//  ViewController.swift
//  Brickbreaker
//
//  Created by Mac House on 6/10/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func start(_ sender: Any) {
        let gameView = GameView()
        view.addSubview(gameView)
    }
}


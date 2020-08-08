//
//  StatusBar.swift
//  Brickbreaker
//
//  Created by Mac House on 7/1/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class StatusBar: UIView {
    var score = Score()
    var lives = Lives()
   
    let safeTop: CGFloat = UIScreen.main.bounds.height < 812 ? 20 : 44

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.addSubview(lives)
        lives.translatesAutoresizingMaskIntoConstraints = false
        lives.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        lives.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lives.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lives.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
        self.addSubview(score)
        score.translatesAutoresizingMaskIntoConstraints = false
        score.rightAnchor.constraint(equalTo: lives.leftAnchor).isActive = true
        score.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        score.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        score.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
    }
}

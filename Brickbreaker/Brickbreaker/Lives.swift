//
//  Lives.swift
//  Brickbreaker
//
//  Created by Mac House on 7/1/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class Lives: UIView {
    let one = UIImageView()
    let two = UIImageView()
    let three = UIImageView()
    
    var livesLeft = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        one.image = UIImage(named: "Live")
        two.image = UIImage(named: "Live")
        three.image = UIImage(named: "Live")
        
        one.translatesAutoresizingMaskIntoConstraints = false
        two.translatesAutoresizingMaskIntoConstraints = false
        three.translatesAutoresizingMaskIntoConstraints = false
        
        one.contentMode = .scaleToFill
        two.contentMode = .scaleToFill
        three.contentMode = .scaleToFill
        
        self.addSubview(one)
        self.addSubview(two)
        self.addSubview(three)
        
        one.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        one.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        one.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        one.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
        three.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        three.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        three.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        three.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
        two.leftAnchor.constraint(equalTo: one.rightAnchor).isActive = true
        two.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        two.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        two.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
    }

}

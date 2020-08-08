//
//  Ball.swift
//  Brickbreaker
//
//  Created by Mac House on 6/10/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class Ball: UIView {
    var radius: CGFloat!
    var vx: CGFloat = 0.15
    var vy: CGFloat = -0.15
    
    convenience init(R: CGFloat){
        self.init(frame: CGRect(x: 0.0,y: 0.0, width: R * 2.0, height: R * 2.0))
        radius = R
        backgroundColor = .red
        self.layer.cornerRadius = R
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

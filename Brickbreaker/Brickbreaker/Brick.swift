//
//  Brick.swift
//  Brickbreaker
//
//  Created by Mac House on 6/10/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class Brick: UIView {
    var hardness: Int!
    convenience init() {
        self.init(frame: CGRect.zero)
        hardness =  Int.random(in: 1...2)
        alpha = CGFloat(hardness) / 2.0
    }
}

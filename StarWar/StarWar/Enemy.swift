//
//  Enemy.swift
//  StarWar
//
//  Created by Techmaster on 3/26/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit

class Enemy: UIImageView {
    
    var vx: CGFloat = 0.0
    var vy: CGFloat = 0.0
    
    
    init(type: Int, center: CGPoint,  vx: CGFloat, vy: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.image = type == 1 ? UIImage(named: "enemy1"): UIImage(named: "enemy2")
        self.vx = vx
        self.vy = vy
        self.center = center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() -> Bool {
        self.center = CGPoint(x: self.center.x + self.vx, y: self.center.y + self.vy)
        if self.center.x < 0 || self.center.x > self.superview!.bounds.width{
            return true
        }
        
        if (self.center.y < 0 || self.center.y > self.superview!.bounds.height) {
            return true
        }
        return false
    }
    
}

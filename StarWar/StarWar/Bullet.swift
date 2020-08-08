//
//  Bullet.swift
//  StarWar
//
//  Created by Techmaster on 3/26/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
import AVFoundation

class Bullet: UIView {
    var vx: CGFloat = 0.0
    var vy: CGFloat = 0.0
    
    init(center: CGPoint, vx: CGFloat, vy: CGFloat) {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 6, height: 8)))
        self.vx = vx
        self.vy = vy
        backgroundColor = UIColor.gray
        self.center = center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Return true if bullet is goes out of mobile screen
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

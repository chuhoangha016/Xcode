//
//  EnemyFleet.swift
//  StarWar
//
//  Created by Techmaster on 3/27/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import Foundation
import UIKit

class EnemyFleet {
    
    let enemy_size : CGFloat = 40.0
    let margin: CGFloat = 3.0
    static let patterns = get_fleet_patterns()
    
    
    
    func buildFleet() -> [Enemy] {
        let randomPattern = Int.random(in: 0 ..< EnemyFleet.patterns.count)
        let pattern = EnemyFleet.patterns[randomPattern]
        var enemies = [Enemy]()
        
        
        var maxEnemyInRow = 0
        //Tìm ra hàng có chiều ngang máy bay dài nhất
        for row in pattern {
            maxEnemyInRow = max(maxEnemyInRow, row.count)
        }
        
        let maxWidth = CGFloat(maxEnemyInRow) * enemy_size
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //Lấy AppDelegate sau đó lấy window để tìm ra kích thước màn hình
        let x_origin_of_fleet = CGFloat.random(in: 0...appDelegate.window!.bounds.width - maxWidth)
        
        
        //Tạo ra các máy bay địch theo đội hình pattern
        let enemy_type = Int.random(in: 1...2)
        for (row, line) in pattern.enumerated() {
            for (col, c) in line.enumerated() {
                if c == "x" {
                    let enemy = Enemy(type: enemy_type,
                                      center: CGPoint(x: x_origin_of_fleet + CGFloat(col) * enemy_size,
                                                      y: 0 + CGFloat(row) * enemy_size),
                                      vx: 0,
                                      vy: 5)
                    enemies.append(enemy)
                    
                }
            }
            
        }
        return enemies
    }
    
    class func get_fleet_patterns() -> [[String]] {
        let pattern1 = [
            "xxxxx",
            " xxx",
            "  x"
        ]
        
        let pattern2 = [
            "xxx",
            "xxx",
            "xxx"
        ]
        
        let pattern3 = [
            "xxx",
            " x",
            "xxx"
        ]
        
        let pattern4 = [
            "xxx",
            " x",
            " x",
            ]
        
        let pattern5 = [
            "x",
            " x",
            "  x",
            "   x",
            ]
        
        return [pattern1, pattern2, pattern3, pattern4, pattern5]
    }
}

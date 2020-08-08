//
//  MainScreen.swift
//  StarWar
//
//  Created by Techmaster on 3/25/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    var timer: Timer!
    var spaceShip : SpaceShip?   //UIImageView(image: UIImage(named: "ourship"))
    
    var size = CGSize.zero
    var bullets = Set<Bullet>()  // Đừng dùng Array bởi khi remove phần tử array trong lúc duyệt sẽ gây crash !
    var enemies = Set<Enemy>()
    
    let enemyFleet = EnemyFleet()
    
    let gameover = UIImageView(image: UIImage(named: "gameover"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        initSpaceShip()
        
        gameover.center = CGPoint(x: view.center.x, y: view.bounds.height + gameover.bounds.height * 0.5)
        view.addSubview(gameover)
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeloop), userInfo: nil, repeats: true)
        }
        
        
        
    }
    
    /* Quy luật sinh các máy bay địch
     1. Máy bay địch sẽ di chuyển thành đội hình định nghĩa ở EnemyFleetPattern
     2. Đội hình máy bay
    */
    func generateEnemies() {
        let fleet = enemyFleet.buildFleet()
        for enemy in fleet {
            enemies.insert(enemy)
            view.addSubview(enemy)
        }
    }
    
    func initSpaceShip() {
        size = view.frame.size
        spaceShip = SpaceShip(superViewSize: size, image: UIImage(named: "ourship")!)
        
        spaceShip?.onFire = {(view: UIView)-> Void in
            let bullet = Bullet(center: CGPoint(x: view.center.x, y: view.frame.origin.y - 5), vx: 0, vy: -10)
       
            self.view.addSubview(bullet)
            self.bullets.insert(bullet)
        }
        view.addSubview(spaceShip!)
    }
    
    @objc func timeloop() {
      /*  for (i, bullet) in bullets.reversed().enumerated() {
            if bullet.move() {
                bullets.remove(at: i)
                bullet.removeFromSuperview()
            }
        }*/
        //Sử dụng set rất phù hợp trong trường hợp phải remove 
        for bullet in bullets {
            if bullet.move() {
                bullets.remove(bullet)
                bullet.removeFromSuperview()
                
            }
        }
        
        for enemy in enemies {
           
            var isEnemyDestroyed = false
            
            if enemy.move() {
                enemies.remove(enemy)
                enemy.removeFromSuperview()
                isEnemyDestroyed = true
              } else {
                //Collision detection
                for bullet in bullets {
                    if enemy.frame.intersects(bullet.frame) {
                        bullets.remove(bullet)
                        bullet.removeFromSuperview()
                        enemies.remove(enemy)
                        enemy.removeFromSuperview()
                        isEnemyDestroyed = true
                        break // Break the loop
                    }
                }
            }
            
            //Check if enemy collides with our space ship
            if !isEnemyDestroyed && enemy.frame.intersects(spaceShip!.frame){
                enemies.remove(enemy)
                enemy.removeFromSuperview()
                spaceShip?.removeFromSuperview()
                gameOver()
            }
        }
    
        //Nếu số lượng enemy giảm còn 3 thì lại tạo phi đội mới
        if enemies.count < 3 {
            generateEnemies()
        }
    }
    
    func gameOver() {
        timer.invalidate()
        
        //Cần phải cho logic dưới dây chậm lại một chút nếu không
        //code trong time loop ở vòng cuối cùng vẫn thực thi đồng thơi việc
        //code dưới đây xóa tất cả các phần tử khiến phần mềm bị crash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            for bullet in self.bullets {
                self.bullets.remove(bullet)
                bullet.removeFromSuperview()
            }
            for enemy in self.enemies {
                self.enemies.remove(enemy)
                enemy.removeFromSuperview()
            }
            UIView.animate(withDuration: 2, animations: {
                self.gameover.center = self.view.center
            }){ (_) in
                
            }
        })
        
        
        
        
        
        
        
    }
    
        

}


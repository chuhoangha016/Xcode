//
//  GameView.swift
//  Brickbreaker
//
//  Created by Mac House on 6/30/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class GameView: UIView {
    var bricks = Set<Brick>()
    var ball = Ball(R: 10)
    var pad = Pad()
    var statusBar = StatusBar()
    let margin: CGFloat = 2.0
    let col: Int = 3
    let row: Int = 3
    
    let cont: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.00, green:0.70, blue:0.27, alpha:1.0)
        button.layer.cornerRadius = 10
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let safeTop: CGFloat = UIScreen.main.bounds.height < 812 ? 20 : 44
    
    var timer: Timer!
    
    let Imag: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: safeTop, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-safeTop))
        self.backgroundColor = .black
        cont.addTarget(self, action: #selector(prepare), for: .touchUpInside)
        self.addSubview(Imag)
        self.addSubview(statusBar)
        Imag.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        Imag.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        Imag.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        Imag.heightAnchor.constraint(equalToConstant: 200)
        self.addSubview(ball)
        self.addSubview(pad)
        buildWall()
        initBallAndPad()
        //setScoreAndLives()
        statusBar.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 38)
        timer = Timer.scheduledTimer(timeInterval: 0.0015, target: self, selector: #selector(run), userInfo: nil, repeats: true)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func prepare() {
        cont.removeFromSuperview()
        initBallAndPad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.timer = Timer()
            self.timer = Timer.scheduledTimer(timeInterval: 0.0015, target: self, selector: #selector(self.run), userInfo: nil, repeats: true)
        }
    }
    
    func buildWall() {
        let brickWidth = (self.bounds.width - CGFloat(col+1) * margin) / CGFloat(col)
        let brickHeight: CGFloat = 40.0
        for i in 0..<row {
            var brickRow = [Brick]()
            for j in 0..<col {
                let brick = Brick()
                brick.frame = CGRect(x: margin*CGFloat(j+1) + CGFloat(j)*brickWidth,
                                     y: 38.0 + CGFloat(i)*(brickHeight + margin),
                                     width: brickWidth,
                                     height: brickHeight)
                brick.backgroundColor = .brown
                self.addSubview(brick)
                brickRow.append(brick)
            }
            for b in brickRow {
                bricks.insert(b) }
        }
    }
    
    func initBallAndPad() {
        ball.vx = 0.15
        ball.vy = -0.15
        let ycenterPad = self.bounds.height - 25.0
        pad.center = CGPoint(x: self.bounds.width * 0.5, y: ycenterPad)
        ball.center = CGPoint(x: self.bounds.width * 0.5, y: ycenterPad - pad.bounds.height * 0.5 - ball.radius)
        self.addSubview(pad)
        pad.isUserInteractionEnabled = true
    }
    
    @objc func run() {
        var ball_new_x = ball.center.x + ball.vx
        var ball_new_y = ball.center.y + ball.vy
        // va vào thành dọc bên phải
        if ball_new_x > self.bounds.width - ball.radius {
            ball.vx = -ball.vx
            ball_new_x = self.bounds.width - ball.radius
        }
        // va thành dọc bên trái
        if ball_new_x < ball.radius {
            ball.vx = -ball.vx
            ball_new_x = ball.radius
        }
        // va vào pad
        if ball_new_y > pad.frame.origin.y - ball.radius {
            if ball_new_x <= pad.frame.origin.x + pad.frame.width && ball_new_x >= pad.frame.origin.x {
                ball.vy = -ball.vy
                ball_new_y = pad.frame.origin.y - ball.radius }
        }
        //va vào đỉnh màn hình
        if ball_new_y < ball.radius {
            ball.vy = -ball.vy
            ball_new_y = ball.radius
        }
        // va truot pad
        if ball_new_y >= self.frame.height + ball.radius {
            statusBar.lives.livesLeft -= 1
            for sub in Set(statusBar.lives.subviews) {
                sub.removeFromSuperview()
                break
            }
            if statusBar.lives.livesLeft == 0 {
                timer.invalidate()
                Imag.image = UIImage(named: "game_over")
                Imag.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.removeFromSuperview()
                }
            }
            else {
                self.addSubview(cont)
                timer.invalidate()
                pad.isUserInteractionEnabled = false
            }
        }
        
        ball.center = CGPoint(x: ball_new_x, y: ball_new_y)
        
        for b in bricks {
            if b.frame.intersects(ball.frame) {
                statusBar.score.impact += 100
                statusBar.score.text = String(statusBar.score.impact)
                b.hardness -= 1
                b.alpha = CGFloat(b.hardness)/2.0
                if (ball.center.x < b.frame.origin.x && ball.center.y < b.frame.origin.y) ||
                   (ball.center.x > b.frame.origin.x + b.frame.width && ball.center.y < b.frame.origin.y) ||
                   (ball.center.x > b.frame.origin.x + b.frame.width && ball.center.y > b.frame.origin.y + b.frame.height) ||
                   (ball.center.x < b.frame.origin.x && ball.center.y > b.frame.origin.y + b.frame.height) {
                    ball.vx = -ball.vx
                    ball.vy = -ball.vy
                }
                else if ball.center.x < b.frame.origin.x { ball.vx = -ball.vx }
                else if ball.center.y < b.frame.origin.y { ball.vy = -ball.vy }
                else if ball.center.x > b.frame.origin.x + b.frame.width { ball.vx = -ball.vx }
                else { ball.vy = -ball.vy }
                if b.hardness == 0 {
                    b.removeFromSuperview()
                    bricks.remove(b)
                    if bricks.count == 0 {
                        timer.invalidate()
                        Imag.image = UIImage(named: "win")
                        Imag.isHidden = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.removeFromSuperview()
                        }
                    }
                }
            }
        }
        ball_new_x = ball.center.x + ball.vx
        ball_new_y = ball.center.y + ball.vy
        
        ball.center = CGPoint(x: ball_new_x, y: ball_new_y)
    }

}

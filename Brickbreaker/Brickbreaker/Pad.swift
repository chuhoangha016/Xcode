//
//  Pad.swift
//  Brickbreaker
//
//  Created by Mac House on 6/10/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class Pad: UIView {
    var initialCenter = CGPoint.zero
    
    convenience init(){
        self.init(frame: CGRect(x: 0.0 ,y: 0.0, width: 120, height: 20))
        backgroundColor = .yellow
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPadPanned(gestureRecognizer:))))
    }
    
    @objc func onPadPanned(gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            self.initialCenter = piece.center
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            if initialCenter.x + translation.x + 60 < UIScreen.main.bounds.width && initialCenter.x + translation.x - 60 > 0{
                let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
                piece.center = newCenter
            }
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
        
    }


}

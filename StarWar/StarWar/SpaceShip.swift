//
//  SpaceShip.swift
//  StarWar
//
//  Created by Techmaster on 3/25/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
typealias onFireHandler = (UIView) -> Void

class SpaceShip: UIImageView {
    var initialCenter = CGPoint.zero
    var onFire : onFireHandler?
    
    init(superViewSize: CGSize, image: UIImage) {
        super.init(image: image)
       
        self.frame = CGRect(x: (superViewSize.width - bounds.width) * 0.5,
                            y: superViewSize.height - bounds.height,
                            width: bounds.width,
                            height: bounds.height)
        
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOurSpaceShipTapped)))
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onOurSpaceShipPanned(gestureRecognizer:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onOurSpaceShipTapped(gestureRecognizer: UITapGestureRecognizer) {
        if (onFire != nil) {
            playSound(mp3file: "laser2")
            onFire!(self)
        }
    }
    
    
    //Di chuyeenr
    @objc func onOurSpaceShipPanned(gestureRecognizer: UIPanGestureRecognizer) {
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
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            piece.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
    }

}

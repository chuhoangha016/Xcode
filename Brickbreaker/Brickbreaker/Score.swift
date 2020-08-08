//
//  Score.swift
//  Brickbreaker
//
//  Created by Mac House on 6/30/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit

class Score: UILabel {
    var impact: Int = 0

    convenience init() {
        self.init(frame: CGRect.zero)
        self.text = String(impact)
        self.font = UIFont.systemFont(ofSize: 20)
        self.textColor = .black
        
        self.textAlignment = .center
    }

}

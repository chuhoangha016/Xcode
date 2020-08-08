////
//  ViewController.swift
//  EarthHour
//
//  Created by Techmaster on 3/29/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bulb: UIImageView!
    @IBOutlet weak var congtac: UIButton!
    
    
    
    var bulbState: Bool = false
    //var bulbState = false
   /* Code cũ
    override func viewDidLoad() {
        super.viewDidLoad()
        bulb.image = UIImage(named: "BulbOff")
        congtac.setTitle("Bật đèn", for: .normal)
        
    }
    @IBAction func onTatDen(_ sender: UIButton) {
        if bulbState {
            bulbState = false
            //Phần code này lặp lại phần khởi tạo trong viewDidLoad, nó khó bảo trì
            bulb.image = UIImage(named: "BulbOff")
            congtac.setTitle("Bật đèn", for: .normal)
        } else {
            bulbState = true
            bulb.image = UIImage(named: "BulbOn")
            congtac.setTitle("Tắt đèn", for: .normal)
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBulbState(bulbState: bulbState)
        
    }
    
    @IBAction func onTatDen(_ sender: UIButton) {
        bulbState = !bulbState
        onBulbState(bulbState: bulbState)
    }
    
    //Code này dễ bảo trì hơn vì phần thay đổi thuộc tính các thành phần giao diện được gom lại vào hàm tái sử dung
    func onBulbState(bulbState: Bool) {
        if bulbState {
            bulb.image = UIImage(named: "BulbOn")
            congtac.setTitle("Tắt đèn", for: .normal)
        } else {
            bulb.image = UIImage(named: "BulbOff")
            congtac.setTitle("Bật đèn", for: .normal)
        }
    }

}


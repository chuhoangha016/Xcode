//
//  ViewController.swift
//  BasicAudioPlayer
//
//  Created by Techmaster on 10/3/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    @IBOutlet weak var sliderMusic: UISlider!
    @IBOutlet weak var lbEnd: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    var player : AVAudioPlayer?
    
    var isPlaying = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudioPlayer()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    func initAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "NhuVayNhe", withExtension: "mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            let duration = player?.duration
            let min = Int(duration!) / 60
            let second = Int(duration!) % 60
            self.lbEnd.text = "\(min):\(second)"
            self.sliderMusic.maximumValue = Float(duration!)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    @objc func updateSlider() {
        if player!.isPlaying == true {
            sliderMusic.value = Float((player!.currentTime))
        }
    }
    
    @IBAction func playOrpause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if !isPlaying {
            player?.play()
            isPlaying = true
        } else {
            player?.stop()
            isPlaying = false
        }
    }
    

}

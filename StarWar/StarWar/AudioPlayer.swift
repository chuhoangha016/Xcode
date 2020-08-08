import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(mp3file: String) {
    if let audioPlayer = audioPlayer, audioPlayer.isPlaying { audioPlayer.stop() }
    
    guard let soundURL = Bundle.main.url(forResource: mp3file, withExtension: "mp3") else { return }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        try AVAudioSession.sharedInstance().setActive(true)
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        audioPlayer?.play()
    } catch let error {
        print(error.localizedDescription)
    }
}

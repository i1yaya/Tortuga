import Foundation
import AVFoundation

class MusicPlayer {
  static let shared = MusicPlayer()
  var audioPlayer: AVAudioPlayer?
  var volumeEnable : Bool = true
  
  func backgroundMusic() {
    if volumeEnable {
      if let bundle = Bundle.main.path(forResource: "Background", ofType: "mp3") {
        let backgroundMusic = NSURL(fileURLWithPath: bundle)
        do {
          audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
          guard let audioPlayer = audioPlayer else { return }
          audioPlayer.numberOfLoops = -1
          audioPlayer.prepareToPlay()
          audioPlayer.play()
        } catch {
          print(error)
        }
      }
    } else {
      guard let audioPlayer = audioPlayer else { return }
      audioPlayer.stop()
    }
  }
}

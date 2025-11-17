import Foundation
import AVFoundation

class SoundPlayer {
  static let shared = SoundPlayer()
  var audioPlayer: AVAudioPlayer?
  var volumeEnable: Bool = true
  
  func wheelSound() {
    if volumeEnable {
      guard let url = Bundle.main.url(forResource: "Wheel", withExtension: "mp3") else { return }
      
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        
        guard let aPlayer = audioPlayer else { return }
        aPlayer.play()
        
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      return
    }
  }
  
  func cubeSound() {
    if volumeEnable {
      guard let url = Bundle.main.url(forResource: "Cube", withExtension: "mp3") else { return }
      
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        
        guard let aPlayer = audioPlayer else { return }
        aPlayer.play()
        
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      return
    }
  }
  
  func cardSound() {
    if volumeEnable {
      guard let url = Bundle.main.url(forResource: "Card", withExtension: "mp3") else { return }
      
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        
        guard let aPlayer = audioPlayer else { return }
        aPlayer.play()
        
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      return
    }
  }
}

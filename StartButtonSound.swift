import SwiftUI
import AVFoundation

class StartButtonSound {
    static var player: AVAudioPlayer?
    
    static func playSound(selectedSound: String) {
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
    
    static func playMusic(selectedSound: String) {
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
    
    static func stopSound() {
        player?.stop()
    }
}


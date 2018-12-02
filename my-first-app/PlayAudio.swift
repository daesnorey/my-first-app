//
//  PlayAudio.swift
//  my-first-app
//
//  Created by user146790 on 12/2/18.
//  Copyright © 2018 user146790. All rights reserved.
//

import AVFoundation

class PlayAudio {
    private static let instance = PlayAudio()
    
    private var player: AVAudioPlayer?
    
    static func getInstance() -> PlayAudio {
        return self.instance
    }
    
    func playSound(with resource: String?) {
        stopSound()
        guard let url = Bundle.main.url(forResource: resource, withExtension: nil) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        print("stopSound")
        guard let player = player else { return }
        player.stop()
        print("sound stopped")
    }
}

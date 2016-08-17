//
//  PodcastPlayer.swift
//  TwiTCast
//
//  Created by Dean Martindale on 9/16/15.
//  Copyright © 2015 Dean Martindale. All rights reserved.
//

import Foundation
import AVFoundation

class PodcastPlayer {
    
    static let sharedInstance = PodcastPlayer()
    
    private var player = AVPlayer(URL: NSURL(string: "http://www.podtrac.com/pts/redirect.mp3/twit.cachefly.net/audio/mbw/mbw0472/mbw0472.mp3")!)
    private var isPlaying = false
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
    
}

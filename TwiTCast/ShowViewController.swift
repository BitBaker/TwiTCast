//
//  ShowViewController.swift
//  TwiTCast
//
//  Created by Dean Martindale on 9/16/15.
//  Copyright © 2015 Dean Martindale. All rights reserved.
//

import UIKit
import AVFoundation

class ShowViewController: UIViewController {
    
    var showTitle: String!
    var showCoverArt: String!
    var player = AVPlayer()
   
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var coverArtImageView: UIImageView!
    
    @IBAction func playButtonPressed(sender: AnyObject) {
        toggle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PodcastPlayer.sharedInstance.currentlyPlaying(){
            playButton.setTitle("Pause", forState: UIControlState.Normal)
        } else {
            playButton.setTitle("Play", forState: UIControlState.Normal)
        }
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
        title = showTitle
        
        let url = NSURL(string: showCoverArt!)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            self.coverArtImageView.image = UIImage(data: data!)
        }
    }
    
    func toggle() {
        if PodcastPlayer.sharedInstance.currentlyPlaying() {
            pauseRadio()
        } else {
            playRadio()
        }
    }
    
    func playRadio() {
        PodcastPlayer.sharedInstance.play()
        playButton.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    func pauseRadio() {
        PodcastPlayer.sharedInstance.pause()
        playButton.setTitle("Play", forState: UIControlState.Normal)
    }
 }

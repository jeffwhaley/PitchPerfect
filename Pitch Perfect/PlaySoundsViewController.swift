//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Whaley on 3/20/15.
//  Copyright (c) 2015 Jeff Whaley. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()

//        if var path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var fileurl = NSURL.fileURLWithPath(path)
//        // println("fileurl= \(fileurl)")
//        }else {
//            println("empty path")
//        }

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

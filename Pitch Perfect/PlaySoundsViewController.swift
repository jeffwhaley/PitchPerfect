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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        let fileurl = NSURL(fileURLWithPath:path!)
        println("fileurl= \(fileurl)")
        audioPlayer = AVAudioPlayer(contentsOfURL: fileurl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
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

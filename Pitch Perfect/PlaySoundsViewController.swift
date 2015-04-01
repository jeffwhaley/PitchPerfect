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
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        //This piece of code sets the sound to always play on the Speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioVariableSpeed(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioVariableSpeed(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioVariablePitch(-1000)
    }
    
    func playAudioVariableSpeed(speed:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
    func playAudioVariablePitch(pitch:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitcheffect = AVAudioUnitTimePitch()
        changePitcheffect.pitch = pitch
        audioEngine.attachNode(changePitcheffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitcheffect, format: nil)
        audioEngine.connect(changePitcheffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

    }
    
}

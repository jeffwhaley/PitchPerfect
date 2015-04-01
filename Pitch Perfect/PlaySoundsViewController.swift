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
    // plays sounds with pitch and speed effects

    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio! // holds recorded sound location
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // uses AVAudioPlayer for different speed playback
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate = true

        // uses AVAudioEngine for different pitch playback
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        //Sets the sound to always play on the speakers
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// functions for the buttons
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
    
    @IBAction func stopPlay(sender: UIButton) {
        stopAudio()
    }
    
// Helper functions
    
    func stopAudio() {
        // stops both player and engine safely
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioVariableSpeed(speed:Float) {
        // plays with variable speed 
        // allowable range 0.5 to 2, 1 is normal speed
        stopAudio()
        
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
    func playAudioVariablePitch(pitch:Float) {
        // plays with variable pitch, pitch units are cents, 1 octave = 1200
        // allowable range is -2400 to 2400, 0 is normal pitch
        
        stopAudio()
        
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
    
    
}

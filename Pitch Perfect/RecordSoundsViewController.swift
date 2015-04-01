//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Whaley on 3/14/15.
//  Copyright (c) 2015 Jeff Whaley. All rights reserved.
//

import UIKit
import AVFoundation

var audioRecorder:AVAudioRecorder!
var recordedAudio:RecordedAudio!    // holds recorded sound location for use in other classes

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    // records a sound file
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        // hide the stop button and enable record
        stopButton.hidden = true
        recordButton.enabled = true

        // show instructions
        recordStatus.text = "Tap to Record"
        recordStatus.hidden = false
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        // record audio into a unique file name
        // BEWARE: the sound files are not deleted so will build up over time...
        
        // show status
        recordStatus.text = "Recording in Progress"
        recordStatus.hidden = false

        // enable stop button
        stopButton.hidden = false
        recordButton.enabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String // place where app can store files
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        //Delegate function called when recorder finishes
        
        if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording not successful")
            recordStatus.hidden = true
            stopButton.hidden = true
            recordButton.enabled = true
        }
    }

    @IBAction func Stop(sender: UIButton) {
        // stop button
        
        // hide status while processing
        recordStatus.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
        
        // stop recorder and set audio session to not active
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // seque to play view controller
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
}


//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Jeff Whaley on 3/14/15.
//  Copyright (c) 2015 Jeff Whaley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recordIP: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record users voice
        recordIP.hidden = false
        println("In recordAudio")
        
    }
    @IBAction func Stop(sender: UIButton) {
        recordIP.hidden = true
    }
}


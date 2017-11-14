//
//  RecorderViewController.swift
//  Talkboy
//
//  Created by admin on 11/13/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    
    @IBOutlet weak var recordText: UIButton!
    @IBOutlet weak var playText: UIButton!
    @IBOutlet weak var addText: UIButton!
    @IBOutlet weak var soundNameField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        
    }
    
    @IBAction func recordButton(_ sender: Any) {
        
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordText.setTitle("Record", for: .normal)
            } else {
                audioRecorder.record()
                recordText.setTitle("Stop", for: .normal)
            }
        }
        
        
    }
    
    @IBAction func playButton(_ sender: Any) {
    }
    
    
    @IBAction func addButton(_ sender: Any) {
    }
}

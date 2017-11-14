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
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let pathComponents = [basePath, "audio.m4a"]
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                self.audioURL = audioURL
                var settings : [String:Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                try? audioRecorder = AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        playText.isEnabled = false
        soundNameField.isEnabled = false
        addText.isEnabled = false
    }
    
    @IBAction func recordButton(_ sender: Any) {
        
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                recordText.setTitle("Record", for: .normal)
                playText.isEnabled = true
                soundNameField.isEnabled = true
                addText.isEnabled = true
            } else {
                audioRecorder.record()
                recordText.setTitle("Stop", for: .normal)
                playText.isEnabled = false
                soundNameField.isEnabled = false
                addText.isEnabled = false
            }
        }
        
        
    }
    
    @IBAction func playButton(_ sender: Any) {
        if let audioURL = self.audioURL {
            try? audioPlayer = AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
    }
    
    
    @IBAction func addButton(_ sender: Any) {
    }
}

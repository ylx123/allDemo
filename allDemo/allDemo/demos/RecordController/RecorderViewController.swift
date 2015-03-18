//
//  RecordController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate {

    var recordButton:UIButton!
    var stopButton:UIButton!
    var playButton:UIButton!
    var recorder:AVAudioRecorder!
    var player:AVAudioPlayer!
    
    
    var soundFileURL:NSURL?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        recordButton = UIButton(frame: CGRect(x: 0, y: 100, width: 60, height: 40))
        recordButton.setTitle("录音", forState: UIControlState.Normal)
        recordButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.view.addSubview(recordButton)
        recordButton.addTarget(self, action: "recordAudio:", forControlEvents: UIControlEvents.TouchUpInside)
        
        stopButton = UIButton(frame: CGRect(x: 100, y: 100, width: 60, height: 40))
        stopButton.setTitle("停止", forState: UIControlState.Normal)
        stopButton.addTarget(self, action: "stopRecordingAudio:", forControlEvents: UIControlEvents.TouchUpInside)
        stopButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.view.addSubview(stopButton)
        
        playButton = UIButton(frame: CGRect(x: 200, y: 100, width: 60, height: 40))
        playButton.setTitle("播放", forState: UIControlState.Normal)
        playButton.addTarget(self, action: "playRecordingAudio:", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.view.addSubview(playButton)
        setSessionPlayback()
        
        
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        
        var filename = "recording.m4a"
        var dirPaths = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,  true)
        var docsDir:AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(filename)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        recorder = AVAudioRecorder(URL: NSURL(fileURLWithPath: "\(paths[0])/sound.m4a")!, settings: recordSettings, error: &error)
        if let e = error {
            
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }


       

        // Do any additional setup after loading the view.
    }
    
    func setSessionPlayback() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayback, error:&error) {
            
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func playRecordingAudio(button:UIButton){
        
        println("play")
        player = AVAudioPlayer(contentsOfURL: recorder.url, error: nil)
        player.prepareToPlay()
        player.play()
    
    }

    
    
    func recordAudio(sender: UIButton) {
        
        
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            println("recording. recorder nil")
            recordButton.setTitle("暂停", forState:.Normal)
            playButton.enabled = false
            stopButton.enabled = true
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            println("暂停ing")
            recorder.pause()
            recordButton.setTitle("Continue", forState:.Normal)
            
        } else {
            println("录音。。。")
            recordButton.setTitle("Pause", forState:.Normal)
            playButton.enabled = false
            stopButton.enabled = true
            //            recorder.record()
            recordWithPermission(false)
        }

        
        
    }
    
    
    func stopRecordingAudio(sender: UIButton) {
        recorder.stop()

        println("stop")
        
    }
    
    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("Permission to record granted")
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()

                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        if !session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:&error) {
            println("could not set session category")
            if let e = error {
                println(e.localizedDescription)
            }
        }
        if !session.setActive(true, error: &error) {
            println("could not make session active")
            if let e = error {
                println(e.localizedDescription)
            }
        }
    }
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings, error: &error)
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorder.delegate = self
            recorder.meteringEnabled = true
            recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        }
    }
    

    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool) {
            println("finished recording \(flag)")
            stopButton.enabled = false
            playButton.enabled = true
            recordButton.setTitle("Record", forState:.Normal)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }



}


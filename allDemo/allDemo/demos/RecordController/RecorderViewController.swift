//
//  RecordController.swift
//  allDemo
//
//  Created by nahaowan on 15/3/17.
//  Copyright (c) 2015年 nahaowan. All rights reserved.
//

import UIKit
import AVFoundation

//import QuartzCore


class RecorderViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate,CircleViewAnimationDelegate {

    var recordButton:UIButton!
    var stopButton:UIButton!
    var circleButton:UIButton!
    var playButton:UIButton!
    var recorder:AVAudioRecorder!
    var player:AVAudioPlayer!
    var timer:NSTimer?
    var circleView:CircleView!
    var secondLabel:UILabel!
    var tips:UILabel!
    var multiLayer:MultiplePulsingHaloLayer!
    
    var soundFileURL:NSURL?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var titleLabel = UILabel(frame: CGRect(x: 0, y: 64, width: mw, height: 30))
        titleLabel.text = "添加语音标签"
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)
        
        recordButton = UIButton(frame: CGRect(x:( mw - 50 )/2, y: mh - 50, width: 50, height: 50))
        recordButton.setImage(UIImage(named: "microphone_act.png"), forState: UIControlState.Normal)
        recordButton.setImage(UIImage(named: "microphone_dis.png"), forState: UIControlState.Disabled)
        self.view.addSubview(recordButton)
        var longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        recordButton.addGestureRecognizer(longPress)
        longPress.allowableMovement = 20
        
        
        tips = UILabel(frame: CGRect(x: 0, y: 150, width: mw, height: 70))
        tips.numberOfLines = 0
        tips.textAlignment = NSTextAlignment.Center
        tips.text = "长按录音按钮\n记录下声音\n(最多可以录15秒哦)"
        self.view.addSubview(tips)
        
        
        //圆
        let diceRoll = 0
        var circleWidth = 100
        var circleHeight = circleWidth
        var pointx = Int((mw - CGFloat(circleWidth))/2)
        circleView = CircleView(frame: CGRect(x:pointx, y: 150, width: circleWidth, height: circleHeight))
        circleView.finishDelegate = self
        self.view.addSubview(circleView)

        //秒
        secondLabel = UILabel(frame: circleView.frame)
        secondLabel.text = "0\""
        secondLabel.textAlignment = NSTextAlignment.Center
        secondLabel.textColor = UIColor.redColor()
        secondLabel.hidden = true
        self.view.addSubview(secondLabel)
        
        playButton = UIButton(frame: CGRect(x: 0, y: mh - 50, width: 50, height: 30))
        playButton.setTitle("播放", forState: UIControlState.Normal)
        playButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        playButton.addTarget(self, action: "playRecordingAudio:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playButton)
        
        

    }
    
    func circleViewAnimationDidFinish(it:Int) {
        self.secondLabel.text = "\(it)\""
    }
    func longPress(press:UILongPressGestureRecognizer){
        
        if(press.state == UIGestureRecognizerState.Began){
            
            self.setupRecorder()
            self.recordAudio()
            println("press")
            tips.hidden = true
            secondLabel.hidden = false
            
            //圆圈开始动
            var it:Int = 1
            circleView.animateCircle(it)
            self.secondLabel.text = "\(0)\""
            it++
            timer = NSTimer.scheduledTimerWithTimeInterval(1, repeats: true){
                
                
                if(it >= 15){
                    
                    self.timer?.invalidate()
                }
                self.circleView.animateCircle(it)
                ++it
                
            }

            
            multiLayer = MultiplePulsingHaloLayer(haloLayerNum: 3, andStartInterval: 1)
            multiLayer.radius = 100
            multiLayer.haloLayerColor = UIColor.redColor().CGColor
            multiLayer.position = self.recordButton.center
            multiLayer.buildSublayers()
            self.view.layer.addSublayer(multiLayer)

        
        }else if(press.state == UIGestureRecognizerState.Ended){
            multiLayer.removeFromSuperlayer()
            recorder.stop()
            timer?.invalidate()
        }
        
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func playRecordingAudio(button:UIButton){
        
        
        player = AVAudioPlayer(contentsOfURL: recorder.url, error: nil)
        
        player.prepareToPlay()
        println(player.duration)
        player.play()
    
    }

    
    
    func recordAudio() {
        
        
        if player != nil && player.playing {
            player.stop()
        }
        
        if recorder == nil {
            //recoder 没有准备好
            recordWithPermission(true)
            return
        }
        
        if recorder != nil && recorder.recording {
            //录音中点击按钮
            
        } else {
            
            //录音中

            recordWithPermission(false)
        }

        
        
    }
    

    
    func recordWithPermission(setup:Bool) {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
       
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    self.setSessionPlayAndRecord()
                    if setup {
                        self.setupRecorder()
                    }
                    self.recorder.record()

                } else {
                    //录音授权失败
                }
            })
        } else {
            
        }
    }
    func setSessionPlayAndRecord() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        var error: NSError?
        
        if(!session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker, error: &error)){
        
            if let e = error {
                
            }
        }
        if !session.setActive(true, error: &error) {
            
            if let e = error {
                
            }
        }
        
        
        var audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker
        
       
        

    }
    func setupRecorder() {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        if filemanager.fileExistsAtPath(soundFilePath) {
            
            println("sound exists")
        }
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVEncoderAudioQualityKey : AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey : 16000,
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey : 16000.0
//            AVFormatIDKey: kAudioFormatAppleLossless,
//            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
//            AVEncoderBitRateKey : 320000,
//            AVNumberOfChannelsKey: 2,
//            AVSampleRateKey : 44100.0
        ]
        var error: NSError?
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings as [NSObject : AnyObject], error: &error)
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

    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!,
        error: NSError!) {
            println("\(error.localizedDescription)")
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("finished playing \(flag)")

    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("\(error.localizedDescription)")
    }



}


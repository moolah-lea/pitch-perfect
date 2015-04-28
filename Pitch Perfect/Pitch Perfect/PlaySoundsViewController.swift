//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Murrali Ramasamy on 26/4/15.
//  Copyright (c) 2015 KingPick. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var engine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        engine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowMo(sender: UIButton) {
        audioPlayer.stop()
        engine.stop()
        engine.reset()

        startOrStop(0.5)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        engine.stop()
        engine.reset()
        audioPlayer.stop()
    }
    
    @IBAction func fastMotion(sender: UIButton) {
        audioPlayer.stop()
        engine.stop()
        engine.reset()
 
        startOrStop(2.0)
    }
    
    func startOrStop(rateAmt: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rateAmt
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
        audioPlayer.stop()
        engine.stop()
        engine.reset()
        
        var playerNode = AVAudioPlayerNode()
        engine.attachNode(playerNode)
        
        var mixer = engine.mainMixerNode;
        
        var auTimePitch = AVAudioUnitTimePitch()
        auTimePitch.pitch = pitch
        // NOTE TO SELF: In cents. The default value is 1.0. The range of values is -2400 to 2400
        
        engine.attachNode(auTimePitch)
        
        
        engine.connect(playerNode, to: auTimePitch, format: nil)
        engine.connect(auTimePitch, to: mixer, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        engine.startAndReturnError(nil)
        
        playerNode.play()
        
        
    }
    


}

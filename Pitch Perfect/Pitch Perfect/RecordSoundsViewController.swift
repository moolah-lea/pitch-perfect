//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Murrali Ramasamy on 13/4/15.
//  Copyright (c) 2015 KingPick. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    
    
    @IBOutlet weak var recLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var tapLabel: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //hide the stop button
        tapLabel.hidden = false
        stopButton.hidden = true
        micButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Record the user's voice
        println("In recordAudio")
        tapLabel.hidden = true
        recLabel.hidden = false
        stopButton.hidden = false
        micButton.enabled = false
        
        //TODO: Record the user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            //TODO: Step 1 - Save the recorded audio
            
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
        
            //TODO: Step 2 - Move to the next scene and perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording was not successful")
            recLabel.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRec(sender: UIButton) {
        println("In stopRec")
        recLabel.hidden = true
        stopButton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    
    
}



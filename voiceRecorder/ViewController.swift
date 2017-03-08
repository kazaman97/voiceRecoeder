//
//  ViewController.swift
//  voiceRecorder
//
//  Created by Kazama Ryusei on 2017/03/07.
//  Copyright © 2017年 Malfoy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    let fileManager = FileManager()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"

    @IBAction func recordingButton(_ sender: Any) {
        statusLabel.text = "録音中"
        statusLabel.textColor = UIColor.red
        audioRecorder?.record()
    }
    
    @IBAction func playingButton(_ sender: Any) {
        statusLabel.text = "再生中"
        statusLabel.textColor = UIColor.blue
        self.play()
    }
    
    func setupAudioRecorder() {
        // 再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [
            AVEncoderAudioQualityKey : AVAudioQuality.min.rawValue as AnyObject,
            AVEncoderBitRateKey : 16 as AnyObject,
            AVNumberOfChannelsKey : 2 as AnyObject,
            AVSampleRateKey : 44100.0 as AnyObject
        ]
        do {
            try audioRecorder = AVAudioRecorder(url: self.documentFilePath() as URL, settings: recordSetting)
        } catch {
            statusLabel.text = "初期設定でエラーが起きました"
        }
    }
    
    func play() {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: self.documentFilePath() as URL)
        } catch {
            statusLabel.text = "再生時にエラーが起きました"
        }
        audioPlayer?.play()
    }
    
    func documentFilePath() -> NSURL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask) as [URL]
        let dirURL = urls[0]
        return dirURL.appendingPathComponent(fileName) as NSURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupAudioRecorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  PAN
//
//  Created by 二宮啓 on 2020/02/06.
//  Copyright © 2020 二宮啓. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import GoogleMobileAds


class ViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    let player1 = player()
    let player2 = player()
    let player3 = player()
    let player4 = player()
    let player5 = player()
    let player6 = player()
    let player7 = player()
    let player8 = player()
    let player9 = player()
    let player10 = player()
    let player11 = player()
    let changeSoundPlayer1 = player()
    let changeSoundPlayer2 = player()
    let changeSoundPlayer3 = player()
    let changeSoundPlayer4 = player()
    let changeSoundPlayer5 = player()
    
    //    var colorFlg: Int = 3 //デフォルトは3で水色
    
    var soundName: String = "かち"
    var soundArray:[String] = ["かち","ぽん","ぷち","ぷよん","ぴゃっ"]
    @IBOutlet var soundLabel:UILabel!
    var soundIndex:Int = 0
    
    var number : Int = 0
    var katiNumber : Int = 0
    
    @IBOutlet var katiLabel : UILabel!
    
    @IBOutlet var button1:UIButton!
    @IBOutlet var button2:UIButton!
    @IBOutlet var button3:UIButton!
    @IBOutlet var button4:UIButton!
    @IBOutlet var button5:UIButton!
    @IBOutlet var button6:UIButton!
    @IBOutlet var button7:UIButton!
    @IBOutlet var button8:UIButton!
    @IBOutlet var button9:UIButton!
    @IBOutlet var resetButton:UIButton!
    @IBOutlet var snsButton:UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.adjustsImageWhenHighlighted = false
        button2.adjustsImageWhenHighlighted = false
        button3.adjustsImageWhenHighlighted = false
        button4.adjustsImageWhenHighlighted = false
        button5.adjustsImageWhenHighlighted = false
        button6.adjustsImageWhenHighlighted = false
        button7.adjustsImageWhenHighlighted = false
        button8.adjustsImageWhenHighlighted = false
        button9.adjustsImageWhenHighlighted = false
        resetButton.adjustsImageWhenHighlighted = false
        snsButton.adjustsImageWhenHighlighted = false
        
        snsButton.setTitle("Share", for: .normal)
        snsButton.setTitleColor(UIColor.white, for: .normal)
        snsButton.titleLabel!.font = UIFont(name: "DIN Alternate",size: CGFloat(20))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel!.font = UIFont(name: "DIN Alternate",size: CGFloat(20))
        
        soundLabel.text = soundArray[soundIndex]
        
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
//        let request = GADRequest()
//        request.testDevices = [ "2077ef9a63d2b398840261c8221a0c9b" ]
        bannerView.load(GADRequest())
        
       
        bannerView.delegate = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func pan(sender:UIButton){
        katiNumber += 1
        katiLabel.text = String(katiNumber)
        shortVibrate()
        
        playSound(sender: sender)
        number += 1
        
        sender.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        sender.isEnabled = false
        if number == 9 {
            button1.isEnabled = true
            button1.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button2.isEnabled = true
            button2.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button3.isEnabled = true
            button3.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button4.isEnabled = true
            button4.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button5.isEnabled = true
            button5.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button6.isEnabled = true
            button6.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button7.isEnabled = true
            button7.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button8.isEnabled = true
            button8.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            button9.isEnabled = true
            button9.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            number = 0
        }
    }
    
    @IBAction func reset(){
        
        shortVibrate()
        
        resetButton.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.resetButton.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        }
        
        katiNumber = 0
        katiLabel.text = String(katiNumber)
        
        button1.isEnabled = true
        button1.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button2.isEnabled = true
        button2.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button3.isEnabled = true
        button3.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button4.isEnabled = true
        button4.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button5.isEnabled = true
        button5.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button6.isEnabled = true
        button6.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button7.isEnabled = true
        button7.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button8.isEnabled = true
        button8.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        button9.isEnabled = true
        button9.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        number = 0
        
        player10.playSound(name: soundName)
        
        
    }
    
    @IBAction func sns(){
        
        shortVibrate()
        
        snsButton.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.snsButton.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        }
        
        let text = "無限ぷちぷちで\(katiLabel.text!)回ぷちぷちしたよ。https://apps.apple.com/jp/app/%E7%84%A1%E9%99%90%E3%81%B7%E3%81%A1%E3%81%B7%E3%81%A1/id1498318394"
        let items = [text]
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        
        activityVc.excludedActivityTypes = [
            UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"),
            UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension"),
            UIActivity.ActivityType(rawValue: "com.google"),
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.mail,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,]
        activityVc.popoverPresentationController?.sourceView = self.view
        activityVc.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.width/2,y: 50,width: 0,height: 0);
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
        
        player11.playSound(name: soundName)
        
    }
    
    @IBAction func changeSoundLeft(){
        if soundIndex > 0 {
            soundIndex = soundIndex - 1
            soundName = soundArray[soundIndex]
            soundLabel.text = soundArray[soundIndex]
        }else{
            soundIndex = 4
            soundName = soundArray[soundIndex]
            soundLabel.text = soundArray[soundIndex]
        }
    }
    
    @IBAction func changeSoundRight(){
        if soundIndex < 4 {
            soundIndex = soundIndex + 1
            soundName = soundArray[soundIndex]
            soundLabel.text = soundArray[soundIndex]
        }else{
            soundIndex = 0
            soundName = soundArray[soundIndex]
            soundLabel.text = soundArray[soundIndex]
        }
    }
    
    func shortVibrate() {
        AudioServicesPlaySystemSound(1519);
        AudioServicesDisposeSystemSoundID(1519);
    }
    
    func playSound(sender:UIButton){
        switch sender.tag {
        case 1:
            player1.playSound(name: soundName)
        case 2:
            player2.playSound(name: soundName)
        case 3:
            player3.playSound(name: soundName)
        case 4:
            player4.playSound(name: soundName)
        case 5:
            player5.playSound(name: soundName)
        case 6:
            player6.playSound(name: soundName)
        case 7:
            player7.playSound(name: soundName)
        case 8:
            player8.playSound(name: soundName)
        case 9:
            player9.playSound(name: soundName)
        case 10:
            player10.playSound(name: soundName)
        case 11:
            player11.playSound(name: soundName)
        default:
            break
        }
    }
    
}

// 同時に音楽を再生するために、関数と変数のセットを複数作れるよう、クラスとして定義する。
class player{
    var audioPlayer: AVAudioPlayer!
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self as? AVAudioPlayerDelegate
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
}


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


class ViewController: UIViewController, GADBannerViewDelegate,GADInterstitialDelegate {
    
    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    var buttonArray:[UIButton]!
    var buttonShuffledArray:[UIButton]!
    var gameIndex:Int = 0
    var timeCount = 30.0
    var resetCount = -1
    var timer:Timer!
    
    var playMode = false
    
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
    let player12 = player()
    let changeSoundPlayer1 = player()
    let changeSoundPlayer2 = player()
    let changeSoundPlayer3 = player()
    let changeSoundPlayer4 = player()
    let changeSoundPlayer5 = player()
    
    var firstLaunch: Bool = true
    var firstLaunchSaveData:UserDefaults = UserDefaults.standard
    
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
        
        buttonArray=[button1,button2,button3,button4,button5,button6,button7,button8,button9]
        buttonShuffledArray = buttonArray.shuffled()
        for i in 0...8{
            buttonArray[i].adjustsImageWhenHighlighted = false
//            buttonArray[i].isEnabled = false
        }
        resetButton.adjustsImageWhenHighlighted = false
        snsButton.adjustsImageWhenHighlighted = false
        
        snsButton.titleLabel?.numberOfLines = 2
        snsButton.titleLabel?.textAlignment = NSTextAlignment.center
        snsButton.setTitle("Play\nGame", for: .normal)
        snsButton.setTitleColor(UIColor.white, for: .normal)
        snsButton.titleLabel!.font = UIFont(name: "DIN Alternate",size: CGFloat(20))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.titleLabel!.font = UIFont(name: "DIN Alternate",size: CGFloat(20))
        
        
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-4698067178614890/3086835091"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.delegate = self
        
        interstitial = createAndLoadInterstitial()
        let request = GADRequest()
        interstitial.load(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstLaunchSaveData.object(forKey: "launch") != nil{
            firstLaunch = firstLaunchSaveData.object(forKey: "launch") as! Bool
        }
        if firstLaunch == true {
            // ダイアログ(AlertControllerのインスタンス)を生成します
            //   titleには、ダイアログの表題として表示される文字列を指定します
            //   messageには、ダイアログの説明として表示される文字列を指定します
            let dialog = UIAlertController(title: "このアプリは、音が出ます。ご利用の際はマナーモードをオフにして音をだしてお楽しみください！", message: "", preferredStyle: .alert)
            // 選択肢(ボタン)を2つ(OKとCancel)追加します
            //   titleには、選択肢として表示される文字列を指定します
            //   styleには、通常は「.default」、キャンセルなど操作を無効にするものは「.cancel」、削除など注意して選択すべきものは「.destructive」を指定します
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            // 生成したダイアログを実際に表示します
            self.present(dialog, animated: true, completion: nil)
            firstLaunch = false
            firstLaunchSaveData.set(firstLaunch, forKey: "launch")
        }
      super.viewDidAppear(animated)
      
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
            for i in 0...8{
                buttonArray[i].isEnabled = true
                buttonArray[i].setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            }
            number = 0
        }
    }
    
    @IBAction func reset(){
        
        if timer != nil{
            timer.invalidate()
        }
        
        soundLabel.text = "音を選択"
        
        shortVibrate()
        
        resetButton.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.resetButton.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        }
        
        katiNumber = 0
        katiLabel.text = String(katiNumber)
        
        
        for i in 0...8{
            buttonArray[i].isEnabled = true
            buttonArray[i].setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            buttonArray[i].setTitle("", for: .normal)
        }
        
        number = 0
        
        player10.playSound(name: soundName)
        
        
    }
    
    @IBAction func sns(){
        
        shortVibrate()
        
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
        player12.playSound(name: soundName)
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
        player12.playSound(name: soundName)
    }
    
    func shortVibrate() {
        AudioServicesPlaySystemSound(1519);
        AudioServicesDisposeSystemSoundID(1519);
    }
    
    func playSound(sender:UIButton){
        
      //  players[sender.tag-1].playSound(name: soundName)
        
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


//ゲーム性のところ
extension ViewController{
    @IBAction func gamePlay(){
        shortVibrate()
        
        snsButton.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.snsButton.setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
        }
        player11.playSound(name: soundName)
        playMode = true
        shortVibrate()
        
        if resetCount < 2{
            katiNumber = 0
            katiLabel.text = String(katiNumber)
            resetCount += 1
            timeCount = 30.0
            if timer != nil{
                timer.invalidate()
            }
            timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(self.timerCounter),
                                         userInfo: nil,
                                         repeats: true)
            buttonReset()
        }else{
            resetCount = 0
            if interstitial.isReady {
              interstitial.present(fromRootViewController: self)
            }
        }
        
    }
    
    
    
    
    @objc func timerCounter() {
        if timeCount > 0{
            timeCount -= 0.01
            soundLabel.text = String(floor(timeCount*10)/10)
        }else{
            timeCount = 0
            soundLabel.text = String("終了")
            for i in 0...8{
                buttonArray[i].isEnabled = false
                buttonArray[i].setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
                buttonShuffledArray[i].setTitle("", for: .normal)
            }
            timer.invalidate()
//            sns()
        }
    }
    
    @IBAction func push(sender:UIButton){
        katiNumber += 1
        katiLabel.text = String(katiNumber)
        shortVibrate()
        
        playSound(sender: sender)
        number += 1
        
        sender.setBackgroundImage(UIImage(named:"Active.png"), for: .normal)
        sender.isEnabled = false
        if playMode{
            if gameIndex < 8{
                gameIndex = gameIndex + 1
                buttonShuffledArray[gameIndex].isEnabled = true
            }else{
                buttonReset()
            }
        }else{
            if number == 9 {
                for i in 0...8{
                    buttonArray[i].isEnabled = true
                    buttonArray[i].setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
                }
                number = 0
            }
        }
    }
    
    func buttonReset(){
        buttonShuffledArray = buttonArray.shuffled()
        gameIndex = 0
        for i in 0...8{
            buttonShuffledArray[i].isEnabled = false
            buttonShuffledArray[i].setBackgroundImage(UIImage(named:"Inactive.png"), for: .normal)
            buttonShuffledArray[i].setTitle(String(i + 1), for: .normal)
            buttonShuffledArray[i].setTitleColor(.white, for: .normal)
            buttonShuffledArray[i].titleLabel!.font = UIFont(name: "DIN Alternate",size: CGFloat(24))
        }
        buttonShuffledArray[gameIndex].isEnabled = true
    }
}


//Admob周り
extension ViewController{
    func createAndLoadInterstitial() -> GADInterstitial {
      var interstitial = GADInterstitial(adUnitID: "ca-app-pub-4698067178614890/6920068043")
        interstitial.delegate = self
      interstitial.load(GADRequest())
      return interstitial
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitial = createAndLoadInterstitial()
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
}

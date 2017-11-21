//
//  ViewController.swift
//  NightcoreGenerator
//
//  Created by 新納真次郎 on 2017/11/20.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController {
  
  var m_timer: Timer!
  var m_counter = 0.00
  var m_BPM: Float!
  var m_Hey: AVAudioPlayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // =========== BPM取得処理&BMPに応じた通知処理 by 新納 ================
    // To get songs from libraries
    // let song = n_getSongByPicker()
    // var bpm = n_getBpmFromSong( _song: song )
    //
    // playingTime のオブサーバーを張る(1msあたりの処理を追加する)
    // ==============================================
    
    // ========= まきのゾーン for DidLoad ========
    m_regiSound()
    //ここでBPMを定義してるよ
    m_BPM = 220.0
    // =========================================
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    m_startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    m_timer.invalidate()
  }
  
  func n_getSongByPicker() -> MPMediaItem? {
    return nil
  }
  
  func n_getBPMFromSong( _song : MPMediaItem ) -> Int {
    var rtnBPM: Int = 120
    return rtnBPM
  }
  
  
  //========== ここから牧のエリア ========
  //タイマーらへん
  func m_startTimer() {
    m_timer = Timer.scheduledTimer(timeInterval: (TimeInterval(60 / m_BPM)), target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
  }
  @objc func timerCounter() {
    m_counter += 1
    print(m_counter)
    self.m_Hey.stop()
    m_Hey.currentTime = 0.0
    self.m_Hey.play()
  }
  
  //音らへん
  func m_regiSound() {
    do {
      let m_Path = Bundle.main.url(forResource: "Mhey", withExtension: "caf")
      m_Hey = try AVAudioPlayer(contentsOf: m_Path!)
    } catch {
      print("error")
    }
  }
  
  
  //==================================
}

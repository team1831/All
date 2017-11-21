//
//  ViewController.swift
//  NightcoreGenerator
//
//  Created by 新納真次郎 on 2017/11/20.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // =========== BPM取得処理&BMPに応じた通知処理 by 新納 ================
    // To get songs from libraries
    // let song = n_getSongByPicker()
    // var bpm = n_getBpmFromSong( _song: song )
    // 
    // playingTime のオブサーバーを張る(1msあたりの処理を追加する)
    // ==============================================
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  func n_getSongByPicker() -> MPMediaItem? {
    return nil
  }
  
  func n_getBPMFromSong( _song : MPMediaItem ) -> Int {
    var rtnBPM: Int = 120
    return rtnBPM
  }
  

}


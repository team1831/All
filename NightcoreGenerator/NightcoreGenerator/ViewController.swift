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

class ViewController: UIViewController, AVAudioPlayerDelegate, MPMediaPickerControllerDelegate {
  
  var m_timer: Timer!
  var m_counter = 0.00
  var m_BPM: Float!
  var m_Hey: AVAudioPlayer!
  var n_selectedSong: MPMediaItem!
  var audioPlayer:AVAudioPlayer? // プレイヤー
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // ========= まきのゾーン for DidLoad ========
    m_regiSound()
    //ここでBPMを定義してるよ
    m_BPM = 220.0
    
    // =========================================
    
    // =========== BPM取得処理&BMPに応じた通知処理 by 新納 ================
    n_openMusicLibrary()
    
    //    n_getBPMFromSong( _song: n_selectedSong, callback: { bpm in
    //      self.m_BPM = bpm
    //      self.m_startTimer()
    //    })
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
  }
  
  @IBAction func pushPic(_ sender: Any) {
    print("選曲ボタン")
    n_openMusicLibrary()
  }
  
  func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
    
    // timerがnilじゃない場合、多重に登録されてしまうので初期化しとく
    if( m_timer != nil ){
      m_timer.invalidate()
    }
    
    // このfunctionを抜ける際にピッカーを閉じ、破棄する
    // (defer文はfunctionを抜ける際に実行される)
    defer {
      dismiss(animated: true, completion: nil)
    }
    
    // 選択した曲情報がmediaItemCollectionに入っている
    // mediaItemCollection.itemsから入っているMPMediaItemの配列を取得できる
    let items = mediaItemCollection.items
    if items.isEmpty {
      // itemが一つもなかったので戻る
      return
    }
    
    // 先頭のMPMediaItemを取得し、そのassetURLからプレイヤーを作成する
    n_selectedSong = items[0]
    
    if( n_selectedSong.assetURL != nil ){
      let url = n_selectedSong.assetURL
      BPMAnalyzer.core.getBpmFrom( url!, completion: {[weak self] (bpm) in
        self?.m_BPM = Float(bpm)
        self?.m_startTimer()
        self?.n_playSong( item: (self?.n_selectedSong)! )
      })
    }
  }
  
  func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController){
    dismiss(animated: true, completion: nil)
  }
  
  /* 曲リストを再生回数によってソートする処理 */
  func get(_songList: [MPMediaItem], callback: @escaping ([MPMediaItem]) -> Void) -> Void {
    var rtnSongList = _songList
    if( _songList.count-1 > 0 ){
      for i in 0..<_songList.count-1 {
        var minSong = rtnSongList[i]
        var k = i
        for j in i+1..<_songList.count {
          if( minSong.playCount > rtnSongList[j].playCount ){
            minSong = rtnSongList[j]
            k = j;
          }
        }
        let tmpSong = rtnSongList[i]
        rtnSongList[i] = rtnSongList[k]
        rtnSongList[k] = tmpSong
      }
      callback(rtnSongList)
    }
    callback(rtnSongList)
  }
  
  func n_openMusicLibrary(){
    // MPMediaPickerControllerのインスタンスを作成
    let picker = MPMediaPickerController()
    // ピッカーのデリゲートを設定
    picker.delegate = self
    
    // 複数選択を不可にする。（trueにすると、複数選択できる）
    picker.allowsPickingMultipleItems = false
    // ピッカーを表示する
    present(picker, animated: true, completion: nil)
  }
  
  func n_getBPMFromSong(_song: MPMediaItem, callback: @escaping (Float) -> Void) -> Void {
    var rtnBPM: Float = 0.0
    if( _song.assetURL != nil ){
      let url = _song.assetURL
      BPMAnalyzer.core.getBpmFrom( url!, completion: {[weak self] (bpm) in
        rtnBPM = Float(bpm)!
        callback(rtnBPM)
      })
    }
    callback(rtnBPM)
  }
  
  /* 音楽再生処理(引数: MPMediaItem) */
  func n_playSong(item: MPMediaItem){
    
    if let url = item.assetURL {
      do {
        // itemのassetURLからプレイヤーを作成する
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.delegate = self
      } catch  {
        // エラー発生してプレイヤー作成失敗
        
        // messageLabelに失敗したことを表示
        print("このurlは再生できません")
        audioPlayer = nil
        
        // 戻る
        return
      }
      audioPlayer?.play()
    }
    else {
      print("アイテムのurlがnilなので再生できません")
      audioPlayer = nil
    }
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

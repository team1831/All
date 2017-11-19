//
//  ViewController.swift
//  test_swift
//
//  Created by 新納真次郎 on 2017/11/20.
//  Copyright © 2017年 nshhhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var m_UNKO = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("テストだよ")
    
    maki()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func maki(){
    m_UNKO.append("UNKO")
    
    print("MAKI専用の\(m_UNKO[0])クラスだぜ")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}


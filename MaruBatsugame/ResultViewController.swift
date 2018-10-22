//
//  ResultViewController.swift
//  MaruBatsugame
//
//  Created by 藤澤洋佑 on 2018/08/23.
//  Copyright © 2018年 Fujisawa-Yousuke. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //勝者を表示
        winner.text = Winner
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //winner変数を受け取る変数
    var Winner = ""
    
    //勝者を表示する
    @IBOutlet weak var winner: UILabel!
    
    
}

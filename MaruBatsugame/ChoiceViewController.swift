//
//  ChoiceViewController.swift
//  MaruBatsugame
//
//  Created by 藤澤洋佑 on 2018/08/23.
//  Copyright © 2018年 Fujisawa-Yousuke. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //○×を選択した時の処理
    //あなたの手
    var player_hand = ""
    //CPUの手
    var cpu_hand = ""
    
    //○を選択したら
    @IBAction func Circle(_ sender: Any) {
        player_hand += "○"
        cpu_hand += "×"
    }
    
    //×を選択したら
    @IBAction func Cross(_ sender: Any) {
        player_hand += "×"
        cpu_hand += "○"
    }
    
    //選択した手を次のViewControllerに渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //もし○と×のいずれかを選択したら
        if segue.identifier == "goBattle" {
            //BattleViewControllerのインスタンスを作成
            let battle_instance = segue.destination as! BattleViewController
            //プレイヤーとCPUの手を渡す
            battle_instance.Player_Hand += self.player_hand
            battle_instance.CPU_Hand += self.cpu_hand
        }
    }
    

}

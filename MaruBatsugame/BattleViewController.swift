//
//  BattleViewController.swift
//  MaruBatsugame
//
//  Created by 藤澤洋佑 on 2018/08/23.
//  Copyright © 2018年 Fujisawa-Yousuke. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //先手を表示する
        switch move {
        case 0:
            MOVE.text = "CPUの番"
        case 1:
            MOVE.text = "あなたの番"
        default: break
        }

        //ScreenSizeの取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        //描画する準備
        let testDraw = DrawView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        //背景を透明にする（描画するViewが遮って見えなくなるから）
        testDraw.isOpaque = false
        //View上に描画する
        self.view.addSubview(testDraw)
        
        //9つのLabelを格納する配列
        let label_Array:[UILabel] = []
        
        //手を表示するラベルを用意
        let Label0 = UILabel(frame: CGRect(x:0, y:screenHeight - screenWidth, width:screenWidth / 3, height:screenWidth / 3))
        let Label1 = UILabel(frame: CGRect(x:screenWidth / 3, y:screenHeight - screenWidth, width:screenWidth / 3, height:screenWidth / 3))
        let Label2 = UILabel(frame: CGRect(x:screenWidth * 2 / 3, y:screenHeight - screenWidth, width:screenWidth / 3, height:screenWidth / 3))
        let Label3 = UILabel(frame: CGRect(x:0, y:screenHeight - screenWidth * 2 / 3, width:screenWidth / 3, height:screenWidth / 3))
        let Label4 = UILabel(frame: CGRect(x:screenWidth / 3, y:screenHeight - screenWidth * 2 / 3, width:screenWidth / 3, height:screenWidth / 3))
        let Label5 = UILabel(frame: CGRect(x:screenWidth * 2 / 3, y:screenHeight - screenWidth * 2 / 3, width:screenWidth / 3, height:screenWidth / 3))
        let Label6 = UILabel(frame: CGRect(x:0, y:screenHeight - screenWidth / 3, width:screenWidth / 3, height:screenWidth / 3))
        let Label7 = UILabel(frame: CGRect(x:screenWidth / 3, y:screenHeight - screenWidth / 3, width:screenWidth / 3, height:screenWidth / 3))
        let Label8 = UILabel(frame: CGRect(x:screenWidth * 2 / 3, y:screenHeight - screenWidth / 3, width:screenWidth / 3, height:screenWidth / 3))
        
        //ラベルを配列に格納
        label_Array.append(Label0)
        label_Array.append(Label1)
        label_Array.append(Label2)
        label_Array.append(Label3)
        label_Array.append(Label4)
        label_Array.append(Label5)
        label_Array.append(Label6)
        label_Array.append(Label7)
        label_Array.append(Label8)
        
        //ラベルを表示
        for i in 0...8 {
            //文字の表示位置を中央に
            label_Array[i].textAlignment = NSTextAlignment.center
            //文字のフォントサイズを120に
            label_Array[i].font = UIFont.systemFont(ofSize: 120)
            //表示
            self.view.addSubview(label_Array[i])
        }
        
    }
    
    //プレイヤーかCPUの番かを示す
    @IBOutlet weak var MOVE: UILabel!
    
    //選択された手を格納する変数
    var Player_Hand = ""
    var CPU_Hand = ""
    
    //勝者を示す変数
    var winner = ""
    
    //9つの領域に手が置かれてるかを示す
    var rest = ["","","","","","","","",""]
    
    //ScreenSizeの取得（グローバル変数としてしよう）
    let screenWIDTH = UIScreen.main.bounds.size.width
    let screenHEIGHT = UIScreen.main.bounds.size.height
    
    //どちらの番であるかを示す
    //0,1のいずれかをランダムに代入
    var move = Int(arc4random_uniform(2))

    //マス目に手を配置、勝敗判定など
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タップを検出？
        let touch = touches.first!
        //タップ座標を取得
        let location = touch.location(in: self.view)
        //格子エリア内をタップした時にのみ以下を実行
        if location.y > screenHEIGHT - screenWIDTH {
            //もしmove==1（あなたの番）の場合
            if move == 1 {
                //座標のx,y座標を取得(CGFloat)
                let locationXY = (location.x, location.y)
                //どの領域に該当するかをチェック
                checkerea_player(locationXY)
                //1列が存在するか（あなたの勝ちかどうか）を判定
                judge_battle_player()
                //引き分けかどうかを判定
                draw_battle()
            //もしmove=0（CPUの番）の場合
            } else if move == 0 {
                //残りの箇所にランダムで手を表示
                random_cpu()
                //1列が存在するか（CPUの勝ちかどうか）を判定
                judge_battle_cpu()
                //引き分けかどうかを判定
                draw_battle()
                //プレイヤーの番に移行
                move = 1
                //Labelの表示を切り替える
                MOVE.text = "あなたの番です"
            }
        }
        
    }
    
    
    //（プレイヤー版）タップした箇所がどの領域に該当するかチェック
    func checkerea_player(_ PointXY: (CGFloat, CGFloat) ) {
        switch PointXY {
            //012
            //345
            //678
            //0をタップした場合
        case(0.0...screenWIDTH / 3, screenHEIGHT - screenWIDTH...screenHEIGHT - screenWIDTH * 2 / 3):
            //もし何も置かれてない場合
            if rest[0] == "" {
                //手を配置する
                rest[0] = Player_Hand
                label_Array[0].text = Player_Hand
                //配置できたときにのみCPUの番へと移行
                move = 0
                //CPU番であると表示
                MOVE.text = "CPUの番です"
            }
            //1をタップした場合
        case(screenWIDTH / 3...screenWIDTH * 2 / 3, screenHEIGHT - screenWIDTH...screenHEIGHT - screenWIDTH * 2 / 3):
            if rest[1] == "" {
                rest[1] = Player_Hand
                label_Array[1].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //2をタップした場合
        case(screenWIDTH * 2 / 3...screenWIDTH, screenHEIGHT - screenWIDTH...screenHEIGHT - screenWIDTH * 2 / 3):
            if rest[2] == "" {
                rest[2] = Player_Hand
                label_Array[2].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //3をタップした場合
        case(0.0...screenWIDTH / 3, screenHEIGHT - screenWIDTH * 2 / 3...screenHEIGHT - screenWIDTH / 3):
            if rest[3] == "" {
                rest[3] = Player_Hand
                label_Array[3].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //4をタップした場合
        case(screenWIDTH / 3...screenWIDTH * 2 / 3, screenHEIGHT - screenWIDTH * 2 / 3...screenHEIGHT - screenWIDTH / 3):
            if rest[4] == "" {
                rest[4] = Player_Hand
                label_Array[4].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //5をタップした場合
        case(screenWIDTH * 2 / 3...screenWIDTH, screenHEIGHT - screenWIDTH * 2 / 3...screenHEIGHT - screenWIDTH / 3):
            if rest[5] == "" {
                rest[5] = Player_Hand
                label_Array[5].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //6をタップした場合
        case(0.0...screenWIDTH / 3, screenHEIGHT - screenWIDTH / 3...screenHEIGHT):
            if rest[6] == "" {
                rest[6] = Player_Hand
                label_Array[6].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //7をタップした場合
        case(screenWIDTH / 3...screenWIDTH * 2 / 3, screenHEIGHT - screenWIDTH / 3...screenHEIGHT):
            if rest[7] == "" {
                rest[7] = Player_Hand
                label_Array[7].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
            //8をタップした場合
        case(screenWIDTH * 2 / 3...screenWIDTH, screenHEIGHT - screenWIDTH / 3...screenHEIGHT):
            if rest[8] == "" {
                rest[8] = Player_Hand
                label_Array[8].text = Player_Hand
                move = 0
                MOVE.text = "CPUの番です"
            }
        default: break
        }
    }
    
    
    //空いてる領域にランダムでcpuの手を格納
    func random_cpu() {
        //ループを終了させるための変数
        let end = 0
        //do-while文を終了させる変数
        var random = 0
        //領域の番号を指定する変数
        //ループ処理文の最初にラベルを設定
        while_end: while end == 0 {
            random = Int(arc4random_uniform(9))
            //空いている領域があった場合
            if rest[random] == "" {
                rest[random] = CPU_Hand
                label_Array[random].text = CPU_Hand
                break while_end
            }
        }
    }
    
    
    //あなたの勝ちかどうかを判定
    func judge_battle_player() {
        //jm(judgenumber)
        var jm = 0
        //横
        while jm <= 6 {
            if rest[jm] == Player_Hand && rest[jm] == rest[jm+1] && rest[jm] == rest[jm+2] {
                print("1")
                //勝者の名前を格納
                winner = "あなたの勝ち"
                //ResultViewControllerに遷移
                performSegue(withIdentifier: "goResult", sender: self)
            }
            jm += 3
        }
        //jmを初期化
        jm = 0
        //縦
        while jm <= 2 {
            if rest[jm] == Player_Hand && rest[jm] == rest[jm+3] && rest[jm] == rest[jm+6] {
                print("1")
                winner = "あなたの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            jm += 1
        }
        //jmを初期化
        jm = 0
        //左上右下斜め
        while jm <= 0 {
            if rest[jm] == Player_Hand && rest[jm] == rest[jm+4] && rest[jm] == rest[jm+8] {
                print("1")
                winner = "あなたの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            //ループを止める
            jm += 1
        }
        //jmを設定
        jm = 2
        //右上左下
        while jm <= 2 {
            if rest[jm] == Player_Hand && rest[jm] == rest[jm+2] && rest[jm] == rest[jm+4] {
                print("1")
                winner = "あなたの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            //ループを止める
            jm += 1
        }
        jm = 0
    }
    
    
    //CPUの勝ちかどうかを判定
    func judge_battle_cpu() {
        //jm(judgenumber)
        var jm = 0
        //横
        while jm <= 6 {
            if rest[jm] == CPU_Hand && rest[jm] == rest[jm+1] && rest[jm] == rest[jm+2] {
                //勝者の名前を格納
                winner = "CPUの勝ち"
                //ResultViewControllerに遷移
                performSegue(withIdentifier: "goResult", sender: self)
            }
            jm += 3
        }
        //jmを初期化
        jm = 0
        //縦
        while jm <= 2 {
            if rest[jm] == CPU_Hand && rest[jm] == rest[jm+3] && rest[jm] == rest[jm+6] {
                winner = "CPUの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            jm += 1
        }
        //jmを初期化
        jm = 0
        //左上右下斜め
        while jm <= 0 {
            if rest[jm] == CPU_Hand && rest[jm] == rest[jm+4] && rest[jm] == rest[jm+8] {
                winner = "CPUの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            //ループを止める
            jm += 1
        }
        //jmを設定
        jm = 2
        //右上左下
        while jm <= 2 {
            if rest[jm] == CPU_Hand && rest[jm] == rest[jm+2] && rest[jm] == rest[jm+4] {
                winner = "CPUの勝ち"
                performSegue(withIdentifier: "goResult", sender: self)
            }
            //ループを止める
            jm += 1
        }
        jm = 0
    }
    
    
    //引き分けを通知
    func draw_battle() {
        //空ではない領域の数をカウント
        var count_area = 0
        for i in 0...8 {
            if rest[i] != "" {
                count_area += 1
            }
        }
        if count_area == 9 {
            performSegue(withIdentifier: "goDraw", sender: nil)
        }
    }
    
    
    //勝敗判定でgoResultに遷移する際の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goResult" {
            //遷移先のインスタンスを作成
            let result_instance = segue.destination as! ResultViewController
            //勝者の名前を渡す
            result_instance.Winner = self.winner
        } else if segue.identifier == "goDraw" {
            //引き分けを表示
            winner = "引き分け"
            //遷移先のインスタンスを作成
            let result_instance = segue.destination as! ResultViewController
            //勝者の名前を渡す
            result_instance.Winner = self.winner
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

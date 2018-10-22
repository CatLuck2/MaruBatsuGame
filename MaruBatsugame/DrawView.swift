//
//  DrawView.swift
//  MaruBatsugame
//
//  Created by 藤澤洋佑 on 2018/08/25.
//  Copyright © 2018年 Fujisawa-Yousuke. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    //ScreeSize（スマホのサイズ）を取得
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height

    //格子を描画
    override func draw(_ rect: CGRect) {
        //インスタンスを作成
        let line = UIBezierPath()
        //縦線1
        line.move(to: CGPoint(x: screenWidth / 3.0, y: screenHeight - screenWidth))
        line.addLine(to: CGPoint(x: screenWidth / 3.0, y: screenHeight))
        //縦線2
        line.move(to: CGPoint(x: screenWidth * 2 / 3.0, y: screenHeight - screenWidth))
        line.addLine(to: CGPoint(x: screenWidth * 2 / 3.0, y: screenHeight))
        //横線1
        line.move(to: CGPoint(x: 0, y: screenHeight - screenWidth))
        line.addLine(to: CGPoint(x: screenWidth, y: screenHeight - screenWidth))
        //横線2
        line.move(to: CGPoint(x: 0, y: (screenHeight - screenWidth * 2 / 3.0)))
        line.addLine(to: CGPoint(x: screenWidth, y: (screenHeight - screenWidth * 2 / 3.0)))
        //横線3
        line.move(to: CGPoint(x: 0, y: (screenHeight - screenWidth / 3.0)))
        line.addLine(to: CGPoint(x: screenWidth, y: (screenHeight - screenWidth / 3.0)))
        //?
        line.close()
        //色の指定
        UIColor.red.setStroke()
        //幅
        line.lineWidth = 5
        //描画する
        line.stroke()
    }

}

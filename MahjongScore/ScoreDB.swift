//
//  ScoreDB.swift
//  MahjongScore
//
//  Created by Aoyagi Hiroki on 2021/02/08.
//

import UIKit
import Foundation

class ScoreDB{
    /* ツモ(親) */
    let table1: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 500, 700, 800, 1000, 1200, 1300],         //1翻
        [-2, 700, 800, 1000, 1300, 1600, 2000, 2300, 2600],    //2翻
        [-2, 1300, 1600, 2000, 2600, 3200, 3900, 4000, 4000],  //3翻
        [-2, 2600, 3200, 3900, 4000, 4000, 4000, 4000, 4000],  //4翻
        Array(repeating: 4000, count: 9),  //5翻(満貫)
        Array(repeating: 6000, count: 9),  //6~7翻(跳満)
        Array(repeating: 8000, count: 9),  //8~10翻(倍満)
        Array(repeating: 12000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 16000, count: 9),  //役満
        Array(repeating: 32000, count: 9),  //W役満
    ]
    
    /* ツモ(子) */
    // 他の子の支払い
    let table2: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 300, 400, 400, 500, 600, 700],         //1翻
        [-2, 400, 400, 500, 700, 800, 1000, 1200, 1300],    //2翻
        [-2, 700, 800, 1000, 1300, 1600, 2000, 2000, 2000],  //3翻
        [-2, 1300, 1600, 2000, 2000, 2000, 2000, 2000, 2000],  //4翻
        Array(repeating: 2000, count: 9),  //5翻(満貫)
        Array(repeating: 3000, count: 9),  //6~7翻(跳満)
        Array(repeating: 4000, count: 9),  //8~10翻(倍満)
        Array(repeating: 6000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 8000, count: 9),  //役満
        Array(repeating: 16000, count: 9),  //W役満
    ]
    // 親被りの支払い
    // table1と同じ
    
    /* ロン(親) */
    let table3: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 1500, 2000, 2400, 2900, 3400, 3900],         //1翻
        [-2, 2000, 2400, 2900, 3900, 4800, 5800, 6800, 7700],    //2翻
        [-2, 3900, 4800, 5800, 7700, 9600, 11600, 12000, 12000],  //3翻
        [-2, 7700, 9600, 11600, 12000, 12000, 12000, 12000, 12000],  //4翻
        Array(repeating: 12000, count: 9),  //5翻(満貫)
        Array(repeating: 18000, count: 9),  //6~7翻(跳満)
        Array(repeating: 24000, count: 9),  //8~10翻(倍満)
        Array(repeating: 36000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 48000, count: 9),  //役満
        Array(repeating: 96000, count: 9),  //W役満
    ]
    /* ロン(子) */
    let table4: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 1000, 1300, 1600, 2000, 2300, 2600],         //1翻
        [-2, 1300, 1600, 2000, 2600, 3200, 3900, 4500, 5200],    //2翻
        [-2, 2600, 3200, 3900, 5200, 6400, 7700, 8000, 8000],  //3翻
        [-2, 5200, 6400, 7700, 8000, 8000, 8000, 8000, 8000],  //4翻
        Array(repeating: 8000, count: 9),  //5翻(満貫)
        Array(repeating: 12000, count: 9),  //6~7翻(跳満)
        Array(repeating: 16000, count: 9),  //8~10翻(倍満)
        Array(repeating: 24000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 32000, count: 9),  //役満
        Array(repeating: 64000, count: 9),  //W役満
    ]
    
    /* 負数(エラー)のハンドリング */
    func getErrorMessage(errorCode: Int) -> String{
        print("Error: \(errorCode)")
        if(errorCode == -1){
            return "翻数を選択してください"
        }else if(errorCode == -2){
            return "符を選択してください"
        }else if(errorCode == -3){
            return "1翻20符・1翻25符はあり得ません"
        }
        return "不明なエラーです"
    }
    
}

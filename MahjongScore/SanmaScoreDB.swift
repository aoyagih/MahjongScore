//
//  SanmaScoreDB.swift
//  MahjongScore
//
//  Created by Aoyagi Hiroki on 2021/02/12.
//

import Foundation

class SanmaScoreDB{
    /* ツモ(親) */
    let table1: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 800, 1100, 1200, 1500, 1800, 2000],         //1翻
        [-2, 1100, 1200, 1500, 2000, 2400, 3000, 3500, 3900],    //2翻
        [-2, 2000, 2400, 3000, 3900, 4800, 6000, 6000, 6000],  //3翻
        [-2, 3900, 4800, 6000, 6000, 6000, 6000, 6000, 6000],  //4翻
        Array(repeating: 6000, count: 9),  //5翻(満貫)
        Array(repeating: 9000, count: 9),  //6~7翻(跳満)
        Array(repeating: 12000, count: 9),  //8~10翻(倍満)
        Array(repeating: 18000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 24000, count: 9),  //役満
        Array(repeating: 48000, count: 9),  //W役満
    ]
    
    /* ツモ(子) */
    // 他の子の支払い
    let table2: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 500, 600, 600, 800, 900, 1100],         //1翻
        [-2, 600, 600, 800, 1100, 1200, 1500, 1800, 2000],    //2翻
        [-2, 1100, 1200, 1500, 2000, 2400, 3000, 3000, 3000],  //3翻
        [-2, 2000, 2400, 3000, 3000, 3000, 3000, 3000, 3000],  //4翻
        Array(repeating: 3000, count: 9),  //5翻(満貫)
        Array(repeating: 4500, count: 9),  //6~7翻(跳満)
        Array(repeating: 6000, count: 9),  //8~10翻(倍満)
        Array(repeating: 9000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 12000, count: 9),  //役満
        Array(repeating: 24000, count: 9),  //W役満
    ]
    // 親被りの支払い
    let table2_2: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 700, 900, 1000, 1300, 1500, 1700],         //1翻
        [-2, 900, 1000, 1300, 1700, 2000, 2500, 2900, 3300],    //2翻
        [-2, 1700, 2000, 2500, 3300, 4000, 5000, 5000, 5000],  //3翻
        [-2, 3300, 4000, 5000, 5000, 5000, 5000, 5000, 5000],  //4翻
        Array(repeating: 5000, count: 9),  //5翻(満貫)
        Array(repeating: 7500, count: 9),  //6~7翻(跳満)
        Array(repeating: 10000, count: 9),  //8~10翻(倍満)
        Array(repeating: 15000, count: 9),  //11~12翻(三倍満)
        Array(repeating: 20000, count: 9),  //役満
        Array(repeating: 40000, count: 9),  //W役満
    ]
    
    /* ロン(親) */
    let table3: [[Int]] = [
        Array(repeating: -1, count: 9),                        //翻数
        [-2, -3, -3, 1500, 2000, 2400, 2900, 3400, 3900],         //1翻
        [-2, 2000, 2400, 2900, 3900, 4800, 5800, 6800, 7700],    //2翻
        [-2, 3900, 4800, 5800, 7700, 9600, 12000, 12000, 12000],  //3翻
        [-2, 7700, 9600, 12000, 12000, 12000, 12000, 12000, 12000],  //4翻
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
        [-2, 2600, 3200, 3900, 5200, 6400, 8000, 8000, 8000],  //3翻
        [-2, 5200, 6400, 8000, 8000, 8000, 8000, 8000, 8000],  //4翻
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

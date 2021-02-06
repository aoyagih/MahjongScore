//
//  ViewController.swift
//  MahjongScore
//
//  Created by Aoyagi Hiroki on 2021/02/05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //プレイヤー名のUIButtonのOutlet
    @IBOutlet weak var player1NameButton: UIButton!
    @IBOutlet weak var player2NameButton: UIButton!
    @IBOutlet weak var player3NameButton: UIButton!
    @IBOutlet weak var player4NameButton: UIButton!
    
    //プレイヤー点数のUIButtonのOutlet
    @IBOutlet weak var player1ScoreButton: UIButton!
    @IBOutlet weak var player2ScoreButton: UIButton!
    @IBOutlet weak var player3ScoreButton: UIButton!
    @IBOutlet weak var player4ScoreButton: UIButton!
    
    //点数更新用のUITextField(マイナスボタンをつけるためにグローバル変数にしている。)
    var numberTextField: UITextField?
    
    //4人のプレイヤー点数の和のUILabel(合計100,000点なら正しい)
    @IBOutlet weak var scoreSumLabel: UILabel!
    
    //プレイヤー名のUIButtonを押すと、UITextField付きのDialogが出てきて名前を変更できる
    @IBAction func updatePlayer1Name(_ sender: Any) {
        showUpdateNameDialog(index: 0, button: player1NameButton)
    }
    @IBAction func updatePlayer2Name(_ sender: Any) {
        showUpdateNameDialog(index: 1, button: player2NameButton)
    }
    @IBAction func updatePlayer3Name(_ sender: Any) {
        showUpdateNameDialog(index: 2, button: player3NameButton)
    }
    @IBAction func updatePlayer4Name(_ sender: Any) {
        showUpdateNameDialog(index: 3, button: player4NameButton)
    }
    //プレイヤー点数のUIButtonを押すと、UITextField付きのDialogが出てきて点数を変更できる
    @IBAction func updatePlayer1Score(_ sender: Any) {
        showUpdateScoreDialog(index: 0, button: player1ScoreButton)
    }
    @IBAction func updatePlayer2Score(_ sender: Any) {
        showUpdateScoreDialog(index: 1, button: player2ScoreButton)
    }
    @IBAction func updatePlayer3Score(_ sender: Any) {
        showUpdateScoreDialog(index: 2, button: player3ScoreButton)
    }
    @IBAction func updatePlayer4Score(_ sender: Any) {
        showUpdateScoreDialog(index: 3, button: player4ScoreButton)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaultsに保存されていたプレイヤー名、点数をロードする
        loadPlayerName()
        loadPlayerScore()
        updateScoreSum()
    }
    
    //UserDefaultsに保存されていたプレイヤー名をロードする
    func loadPlayerName(){
        let key = "playerName"   //UserDefaultsのkey
        let playerName = UserDefaults.standard.stringArray(forKey: key) ?? ["player1", "player2", "player3", "player4"]
        player1NameButton.setTitle(playerName[0], for: .normal)
        player2NameButton.setTitle(playerName[1], for: .normal)
        player3NameButton.setTitle(playerName[2], for: .normal)
        player4NameButton.setTitle(playerName[3], for: .normal)
        print(playerName)
        UserDefaults.standard.set(playerName, forKey: key)
    }
    
    //UserDefaultsに保存されていたプレイヤー点数をロードする
    func loadPlayerScore(){
        let key = "playerScore"   //UserDefaultsのkey
        let playerScore = UserDefaults.standard.array(forKey: key) as? [Int] ?? [25000, 25000, 25000, 25000]
        player1ScoreButton.setTitle(String(playerScore[0]), for: .normal)
        player2ScoreButton.setTitle(String(playerScore[1]), for: .normal)
        player3ScoreButton.setTitle(String(playerScore[2]), for: .normal)
        player4ScoreButton.setTitle(String(playerScore[3]), for: .normal)
        UserDefaults.standard.set(playerScore, forKey: key)
    }

    //4人のプレイヤー点数の和を計算し、表示する
    func updateScoreSum(){
        let key = "playerScore"   //UserDefaultsのkey
        let playerScore = UserDefaults.standard.array(forKey: key) as? [Int] ?? [25000, 25000, 25000, 25000]
        let sum = playerScore[0] + playerScore[1] + playerScore[2] + playerScore[3]
        scoreSumLabel.text = String(sum)
    }
    
    //プレイヤー名の変更ダイアログについて
    func showUpdateNameDialog(index: Int, button: UIButton) {
        let key = "playerName"   //UserDefaultsのkey
        var playerData = UserDefaults.standard.stringArray(forKey: key)

        var alertTextField: UITextField?
        //タイトルの表示
        let alert = UIAlertController(
            title: "\(index+1)人目のプレイヤー名を入力",
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        //textFieldの設定
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                alertTextField = textField
                textField.text = playerData?[index]
                button.setTitle(textField.text, for: .normal)
            }
        )
        //キャンセル時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: UIAlertAction.Style.cancel,
                handler: {
                    (action:UIAlertAction!) -> Void in
                        button.setTitle(playerData?[index], for: .normal)
                }
            )
        )
        //決定時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "決定",
                style: UIAlertAction.Style.default
            ) { _ in
                if let text = alertTextField?.text {
                    print(playerData ?? "")  //更新前のデータ配列
                    let old = playerData?[index] ?? ""
                    button.setTitle(text, for: .normal)
                    print("Update Name: \(old)  -> \(text)")
                    playerData?[index] = text
                    UserDefaults.standard.set(playerData, forKey: key)
                    let newArray = UserDefaults.standard.stringArray(forKey: key)
                    print(newArray ?? "")  //更新後のデータ配列
                }
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //プレイヤーの点数の変更について
    func showUpdateScoreDialog(index: Int, button: UIButton) {
        let key = "playerScore"   //UserDefaultsのkey
        var playerData = UserDefaults.standard.array(forKey: key) as? [Int]

        //タイトルの表示
        let alert = UIAlertController(
            title: "\(index+1)人目の点数を入力",
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        //textFieldの設定
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                self.numberTextField = textField
                textField.text = String(playerData?[index] ?? -1)
                textField.keyboardType = .numberPad   //数字のみのキーボードに変更
                
                // トビ用にマイナスボタンをつける
                // ツールバーのインスタンスを作成
                let toolBar = UIToolbar(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: self.view.bounds.size.width,
                                                      height: 44)
                )
                // ツールバーに配置するアイテムのインスタンスを作成
                let okButton: UIBarButtonItem = UIBarButtonItem(title: "マイナス",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(self.tapMinusButton(_:))
                )
                // アイテムを配置
                toolBar.items = [okButton]
                // ツールバーのサイズを指定
                toolBar.sizeToFit()
                // デリゲートを設定
                textField.delegate = self
                // テキストフィールドにツールバーを設定
                textField.inputAccessoryView = toolBar
                
                
                button.setTitle(textField.text, for: .normal)
            }
        )
        //キャンセル時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: UIAlertAction.Style.cancel,
                handler: {
                    (action:UIAlertAction!) -> Void in
                        button.setTitle(String(playerData?[index] ?? -1), for: .normal)
                    self.updateScoreSum()
                }
            )
        )
        //決定時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "決定",
                style: UIAlertAction.Style.default
            ) { _ in
                if let text = self.numberTextField?.text {
                    print(playerData ?? "")  //更新前のデータ配列
                    let old = playerData?[index] ?? -1
                    playerData?[index] = Int(text) ?? -1
                    button.setTitle(String(playerData?[index] ?? -1), for: .normal)
                    print("Update Score: \(old)  -> \(playerData?[index] ?? -1)")
                    UserDefaults.standard.set(playerData, forKey: key)
                    let value = UserDefaults.standard.array(forKey: key) as? [Int]
                    print(value ?? "")  //更新後のデータ配列
                    self.updateScoreSum()
                }
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
    // 数字キーボードのマイナスボタンを押したときのメソッド
    @objc func tapMinusButton(_ sender: UIButton){
        self.numberTextField?.toggleMinus()
    }
    
    
}

// 数字キーボードのマイナスボタンを拡張
extension UITextField {
    func toggleMinus() {
        guard let text = self.text, !text.isEmpty else { return }
        self.text = String(text.hasPrefix("-") ? text.dropFirst() : "-\(text)")
    }
}

//
//  ViewController.swift
//  MahjongScore
//
//  Created by Aoyagi Hiroki on 2021/02/05.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    /* プレイヤー名・点数 */
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
        showUpdateNameDialog(index: 0, button: player1NameButton, difButton: player1DifButton)
    }
    @IBAction func updatePlayer2Name(_ sender: Any) {
        showUpdateNameDialog(index: 1, button: player2NameButton, difButton: player2DifButton)
    }
    @IBAction func updatePlayer3Name(_ sender: Any) {
        showUpdateNameDialog(index: 2, button: player3NameButton, difButton: player3DifButton)
    }
    @IBAction func updatePlayer4Name(_ sender: Any) {
        showUpdateNameDialog(index: 3, button: player4NameButton, difButton: player4DifButton)
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
    
    /* 機能 */
    //プレイヤー点差表示のUIButtonのOutlet
    @IBOutlet weak var player1DifButton: UIButton!
    @IBOutlet weak var player2DifButton: UIButton!
    @IBOutlet weak var player3DifButton: UIButton!
    @IBOutlet weak var player4DifButton: UIButton!
    //プレイヤー点差表示のUIButtonを押すと、Dialogが出てきて点差を確認できる
    @IBAction func showPlayer1ScoreDif(_ sender: Any) {
        showScoreDifDialog(index: 0)
    }
    @IBAction func showPlayer2ScoreDif(_ sender: Any) {
        showScoreDifDialog(index: 1)
    }
    @IBAction func showPlayer3ScoreDif(_ sender: Any) {
        showScoreDifDialog(index: 2)
    }
    @IBAction func showPlayer4ScoreDif(_ sender: Any) {
        showScoreDifDialog(index: 3)
    }
    
    
    /* ツモ(親)ボタン */
    @IBOutlet weak var drawParentTextField: UITextField!
    var pickerView1: UIPickerView = UIPickerView()
    let list1: [[String]] = [
        ["和了者", "player1", "player2", "player3", "player4"],
        ["翻数","1翻","2翻","3翻","4翻","5翻","6~7翻","8~10翻","11~12翻","役満","W役満"],
        ["符","20符","25符","30符","40符","50符","60符","70符","80符"]
    ]
    // 決定ボタン押下
    @objc func done1() {
        drawParentTextField.endEditing(true)
        let db: ScoreDB = ScoreDB()
        let winnerNum = pickerView1.selectedRow(inComponent: 0) - 1
        //1人あたりの支払い
        let pay = db.table1[pickerView1.selectedRow(inComponent: 1)][pickerView1.selectedRow(inComponent: 2)]
        let han = list1[1][pickerView1.selectedRow(inComponent: 1)]  //翻数
        let fu = list1[2][pickerView1.selectedRow(inComponent: 2)]   //符
        if(winnerNum != -1){
            if(pay >= 0){
                //正常な値の場合
                var scoreChange = [-pay, -pay, -pay, -pay]
                scoreChange[winnerNum] = pay * 3
                print(scoreChange)
                showScoreUpdateCheckDialog(scoreChange: scoreChange)
                print("和了者:\(list1[0][winnerNum+1]), \(han)\(fu), \(pay)オール")
            }else{
                //スコアエラー
                showSimpleAlert(title: "エラー", message: db.getErrorMessage(errorCode: pay))
            }
        }else{
            //和了者エラー
            showSimpleAlert(title: "エラー", message: "和了者を選択してください")
        }
    }
    
    /* ツモ(子)ボタン */
    @IBOutlet weak var drawChildTextField: UITextField!
    var pickerView2: UIPickerView = UIPickerView()
    let list2: [[String]] = [
        ["和了者", "player1", "player2", "player3", "player4"],
        ["親被り", "player1", "player2", "player3", "player4"],
        ["翻数","1翻","2翻","3翻","4翻","5翻","6~7翻","8~10翻","11~12翻","役満","W役満"],
        ["符","20符","25符","30符","40符","50符","60符","70符","80符"]]
    // 決定ボタン押下
    @objc func done2() {
        drawChildTextField.endEditing(true)
        let db: ScoreDB = ScoreDB()
        let winnerNum = pickerView2.selectedRow(inComponent: 0) - 1
        let parentNum = pickerView2.selectedRow(inComponent: 1) - 1
        //1人あたりの支払い
        let pay_child = db.table2[pickerView2.selectedRow(inComponent: 2)][pickerView2.selectedRow(inComponent: 3)]
        let pay_parent = db.table1[pickerView2.selectedRow(inComponent: 2)][pickerView2.selectedRow(inComponent: 3)]
        let han = list2[2][pickerView2.selectedRow(inComponent: 2)]  //翻数
        let fu = list2[3][pickerView2.selectedRow(inComponent: 3)]   //符
        if(winnerNum != -1){
            if(parentNum != -1){
                if(winnerNum != parentNum){
                    if(pay_child >= 0){
                        //正常な値の場合
                        var scoreChange = [-pay_child, -pay_child, -pay_child, -pay_child]
                        scoreChange[parentNum] = -pay_parent
                        scoreChange[winnerNum] = pay_child * 2 + pay_parent
                        print(scoreChange)
                        showScoreUpdateCheckDialog(scoreChange: scoreChange)
                        print("和了者:\(list2[0][winnerNum+1]), 親被り:\(list2[0][parentNum+1]), \(han)\(fu), \(pay_child)・\(pay_parent)")
                    }else{
                        //スコアエラー
                        showSimpleAlert(title: "エラー", message: db.getErrorMessage(errorCode: pay_child))
                    }
                }else{
                    //和了者・親被り者一致エラー
                    showSimpleAlert(title: "エラー", message: "和了者と親被り者が同じです")
                }
            }else{
                //親被りエラー
                showSimpleAlert(title: "エラー", message: "親を選択してください")
            }
        }else{
            //和了者エラー
            showSimpleAlert(title: "エラー", message: "和了者を選択してください")
        }
    }
    
    /* ロンボタン */
    @IBOutlet weak var ronTextField: UITextField!
    var pickerView3: UIPickerView = UIPickerView()
    let list3: [[String]] = [
        ["和了者", "player1", "player2", "player3", "player4"],
        ["放銃者", "player1", "player2", "player3", "player4"],
        ["親or子", "親", "子"],
        ["翻数","1翻","2翻","3翻","4翻","5翻","6~7翻","8~10翻","11~12翻","役満","W役満"],
        ["符","20符","25符","30符","40符","50符","60符","70符","80符"]]
    // 決定ボタン押下
    @objc func done3() {
        ronTextField.endEditing(true)
        let db: ScoreDB = ScoreDB()
        let winnerNum = pickerView3.selectedRow(inComponent: 0) - 1
        let loserNum = pickerView3.selectedRow(inComponent: 1) - 1
        let parentChildNum = pickerView3.selectedRow(inComponent: 2) - 1
        let parentChild = list3[2][pickerView3.selectedRow(inComponent: 2)]  //親or子
        let han = list3[3][pickerView3.selectedRow(inComponent: 3)]  //翻数
        let fu = list3[4][pickerView3.selectedRow(inComponent: 4)]   //符
        if(winnerNum != -1){
            if(loserNum != -1){
                if(winnerNum != loserNum){
                    if(parentChildNum != -1){
                        let pay: Int
                        if(parentChildNum == 0){
                            //親のロン
                            pay = db.table3[pickerView3.selectedRow(inComponent: 3)][pickerView3.selectedRow(inComponent: 4)]
                        }else{
                            //子のロン
                            pay = db.table4[pickerView3.selectedRow(inComponent: 3)][pickerView3.selectedRow(inComponent: 4)]
                        }
                        if(pay >= 0){
                            //正常な値の場合
                            var scoreChange = [0, 0, 0, 0]
                            scoreChange[loserNum] = -pay
                            scoreChange[winnerNum] = pay
                            print(scoreChange)
                            showScoreUpdateCheckDialog(scoreChange: scoreChange)
                            print("和了者:\(list3[0][winnerNum+1]) <- 放銃者:\(list3[0][loserNum+1]), \(han)\(fu)(\(parentChild)), \(pay)")
                        }else{
                            //スコアエラー
                            showSimpleAlert(title: "エラー", message: db.getErrorMessage(errorCode: pay))
                        }
                    }else{
                        //親・子エラー
                        showSimpleAlert(title: "エラー", message: "親か子を選択してください")
                    }
                    
                }else{
                    //和了者・放銃者一致エラー
                    showSimpleAlert(title: "エラー", message: "和了者と放銃者が同じです")
                }
            }else{
                //放銃者エラー
                showSimpleAlert(title: "エラー", message: "放銃者を選択してください")
            }
        }else{
            //和了者エラー
            showSimpleAlert(title: "エラー", message: "和了者を選択してください")
        }
    }
    
    
    /* viewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaultsに保存されていたプレイヤー名、点数をロードする
        loadPlayerName()
        loadPlayerScore()
        updateScoreSum()
        
        setPicker(textField: drawParentTextField, picker: pickerView1) // ツモ(親)ボタン
        setPicker(textField: drawChildTextField, picker: pickerView2) // ツモ(子)ボタン
        setPicker(textField: ronTextField, picker: pickerView3)       //ロンボタン
    }
    
    //UserDefaultsに保存されていたプレイヤー名をロードする
    func loadPlayerName(){
        let key = "playerName"   //UserDefaultsのkey
        let playerName = UserDefaults.standard.stringArray(forKey: key) ?? ["player1", "player2", "player3", "player4"]
        player1NameButton.setTitle(playerName[0], for: .normal)
        player2NameButton.setTitle(playerName[1], for: .normal)
        player3NameButton.setTitle(playerName[2], for: .normal)
        player4NameButton.setTitle(playerName[3], for: .normal)
        player1DifButton.setTitle(playerName[0], for: .normal)
        player2DifButton.setTitle(playerName[1], for: .normal)
        player3DifButton.setTitle(playerName[2], for: .normal)
        player4DifButton.setTitle(playerName[3], for: .normal)
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
    
    //点数移動用のpickerをセット
    func setPicker(textField: UITextField, picker: UIPickerView) {
        // ピッカー設定
        picker.delegate = self
        picker.dataSource = self
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1))
        if(picker == pickerView2){
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done2))
        }else if(picker == pickerView3){
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done3))
        }
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // インプットビュー設定
        textField.inputView = picker
        textField.inputAccessoryView = toolbar
    }
    
    
    /* プレイヤー名・点数 */
    //プレイヤー名の変更ダイアログについて
    func showUpdateNameDialog(index: Int, button: UIButton, difButton: UIButton) {
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
                    difButton.setTitle(text, for: .normal)
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
    
    
    /* 機能 */
    //プレイヤーの点数差分の表示について
    func showScoreDifDialog(index: Int) {
        let key = "playerScore"   //UserDefaultsのkey
        let playerScore = UserDefaults.standard.array(forKey: key) as! [Int]
        let dif0 = makeSignedStringInt(x: playerScore[0] - playerScore[index])
        let dif1 = makeSignedStringInt(x: playerScore[1] - playerScore[index])
        let dif2 = makeSignedStringInt(x: playerScore[2] - playerScore[index])
        let dif3 = makeSignedStringInt(x: playerScore[3] - playerScore[index])
        let key2 = "playerName"   //UserDefaultsのkey
        let playerName = UserDefaults.standard.stringArray(forKey: key2)
        showSimpleAlert(title: "点差確認(\(playerName?[index] ?? ""))",
                        message: "\(playerName?[0] ?? ""):     \(dif0)\n\(playerName?[1] ?? ""):      \(dif1)\n\(playerName?[2] ?? ""):      \(dif2)\n\(playerName?[3] ?? ""):      \(dif3)")
    }
    //整数を符号つき文字列に変換する関数
    func makeSignedStringInt(x: Int) -> String{
        if(x > 0){
            return "+" + String(x)
        }else if(x == 0){
            return "±" + String(x)
        }else{
            return String(x)
        }
    }
    //TitleとMessageのみのシンプルなAlertを表示する
    func showSimpleAlert(title: String, message: String)  {
        let alert:UIAlertController = UIAlertController(title: title,
                                                        message: message, preferredStyle: .alert)
        let action:UIAlertAction = UIAlertAction(title: "OK",
                                                 style: .default,
                                                 handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //プレイヤーの点数更新の確認用ダイアログ
    func showScoreUpdateCheckDialog(scoreChange: [Int]) {
        let key1 = "playerName"   //UserDefaultsのkey
        let playerNames = UserDefaults.standard.stringArray(forKey: key1)
        let key2 = "playerScore"   //UserDefaultsのkey
        let oldScores = UserDefaults.standard.array(forKey: key2) as? [Int]
        var newScores = [0, 0, 0, 0]
        for i in 0...3{
            newScores[i] = ((oldScores?[i] ?? 0) + scoreChange[i])
        }
        for i in 0...3{
            print("\(playerNames?[i] ?? ""):  \(newScores[i])(\(makeSignedStringInt(x: scoreChange[i])))")
        }
        
        let alert:UIAlertController = UIAlertController(title: "以下の点数に更新します",
                                                        message: "\(playerNames?[0] ?? ""):  \(newScores[0])(\(makeSignedStringInt(x: scoreChange[0])))\n\(playerNames?[1] ?? ""):  \(newScores[1])(\(makeSignedStringInt(x: scoreChange[1])))\n\(playerNames?[2] ?? ""):  \(newScores[2])(\(makeSignedStringInt(x: scoreChange[2])))\n\(playerNames?[3] ?? ""):  \(newScores[3])(\(makeSignedStringInt(x: scoreChange[3])))", preferredStyle: .alert)
        //キャンセル時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: UIAlertAction.Style.cancel,
                handler: nil
            )
        )
        //決定時のハンドラ
        alert.addAction(
            UIAlertAction(
                title: "決定",
                style: UIAlertAction.Style.default
            ) { _ in
                self.updateScores(newScores: newScores)
            }
        )
        present(alert, animated: true, completion: nil)
    }
    
    //スコア表示の更新
    func updateScores(newScores: [Int]) {
        //UserDefaultsの値の更新
        let key = "playerScore"   //UserDefaultsのkey
        UserDefaults.standard.set(newScores, forKey: key)
        //画面上部のスコア表示の更新
        player1ScoreButton.setTitle(String(newScores[0]), for: .normal)
        player2ScoreButton.setTitle(String(newScores[1]), for: .normal)
        player3ScoreButton.setTitle(String(newScores[2]), for: .normal)
        player4ScoreButton.setTitle(String(newScores[3]), for: .normal)
        //スコア合計表示の更新
        updateScoreSum()
    }
}

// 数字キーボードのマイナスボタンを拡張
extension UITextField {
    func toggleMinus() {
        guard let text = self.text, !text.isEmpty else { return }
        self.text = String(text.hasPrefix("-") ? text.dropFirst() : "-\(text)")
    }
}


extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == pickerView1){
            return list1.count
        }else if(pickerView == pickerView2){
            return list2.count
        }else if(pickerView == pickerView3){
            return list3.count
        }
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerView1){
            return list1[component].count
        }else if(pickerView == pickerView2){
            return list2[component].count
        }else if(pickerView == pickerView3){
            return list3[component].count
        }
        return 1
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerView1){
            if(component == 0){
                if(row == 0){
                    return "和了者"
                }
                let key = "playerName"   //UserDefaultsのkey
                let playerNames = UserDefaults.standard.stringArray(forKey: key)
                return playerNames?[row-1]
            }
            return list1[component][row]
        }else if(pickerView == pickerView2){
            if(component == 0 && row == 0){
                return "和了者"
            }else if(component == 1 && row == 0){
                return "親被り"
            }else if(component == 0 || component == 1){
                let key = "playerName"   //UserDefaultsのkey
                let playerNames = UserDefaults.standard.stringArray(forKey: key)
                return playerNames?[row-1]
            }
            return list2[component][row]
        }else if(pickerView == pickerView3){
            if(component == 0 && row == 0){
                return "和了者"
            }else if(component == 1 && row == 0){
                return "放銃者"
            }else if(component == 0 || component == 1){
                let key = "playerName"   //UserDefaultsのkey
                let playerNames = UserDefaults.standard.stringArray(forKey: key)
                return playerNames?[row-1]
            }
            return list3[component][row]
        }
        return list3[component][row]
    }
}

//
//  ScoreTableViewController.swift
//  MahjongScore
//
//  Created by Aoyagi Hiroki on 2021/02/13.
//

import UIKit

class ScoreTableViewController: UIViewController {

    @IBOutlet weak var playerNumSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableSegmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    let images = [["scoreTable4-1","scoreTable4-2","scoreTable4-3"],
                  ["scoreTable3-1","scoreTable3-2","scoreTable3-3"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(x: playerNumSegmentedControl.selectedSegmentIndex, y: tableSegmentedControl.selectedSegmentIndex)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func controlPlayerNum(_ sender: UISegmentedControl) {
        setImage(x: sender.selectedSegmentIndex, y: tableSegmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func controlTables(_ sender: UISegmentedControl) {
        setImage(x: playerNumSegmentedControl.selectedSegmentIndex, y: sender.selectedSegmentIndex)
    }
    
    func setImage(x: Int, y: Int){
        let image = UIImage(named: images[x][y])
        imageView.image = image
    }
    
    
    @IBAction func showInfo(_ sender: Any) {
        showSimpleAlert(title: "点数表について", message:  "・「セガNET麻雀 MJ」の点数表を参照\n・3翻60符,4翻30符は切り上げ満貫を採用\n・三麻はツモ損なし")
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
    
    
}

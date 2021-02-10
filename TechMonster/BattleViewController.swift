//
//  BattleViewController.swift
//  TechMonster
//
//  Created by Towa Aoyagi on 2021/02/10.
//

import UIKit

class BattleViewController: UIViewController {
    
    @IBOutlet var playerName: UILabel!
    @IBOutlet var playerImage: UIImageView!
    @IBOutlet var playerHPLabel: UILabel!
    @IBOutlet var playerMPLabel: UILabel!
    @IBOutlet var playerTPLabel: UILabel!
    @IBOutlet var enemyImage: UIImageView!
    @IBOutlet var enemyName: UILabel!
    @IBOutlet var enemyHPLabel: UILabel!
    @IBOutlet var enemyMPLabel: UILabel!
    
    var playerHP = 100
    var playerMP = 0
    var enemyHP = 200
    var enemyMP = 0
    
    var gameTimer: Timer!
    var isPlayerAttackAvailable: Bool = true



    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerName.text = "勇者"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

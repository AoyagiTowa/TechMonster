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
    
    var player: Character!
    var enemy: Character!
    
    let techMonManager = TechMonManager.shared
    
    var gameTimer: Timer!
    var isPlayerAttackAvailable: Bool = true



    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = techMonManager.player
        enemy = techMonManager.enemy
        
        updateUI()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        
        gameTimer.fire()

        // Do any additional setup after loading the view.
    }
    
    @objc func updateGame() {
        player.currentMP += 1
        if player.currentMP >= 20 {
            isPlayerAttackAvailable = true
            player.currentMP = 20
        } else {
            isPlayerAttackAvailable = false
        }
        enemy.currentMP += 1
        
        if enemy.currentMP >= 35 {
            enemyAttack()
            enemy.currentMP = 0
        }
        
        updateUI()
    }
    
    func enemyAttack() {
        techMonManager.damageAnimation(imageView: playerImage)
        techMonManager.playSE(fileName: "SE_attack")
        
        player.currentHP -= enemy.attackPoint
        updateUI()
        if player.currentHP <= 0 {
            finishBattle(vanishImage: playerImage, isPlayerWin: false)
        }
    }
    
    func finishBattle(vanishImage: UIImageView, isPlayerWin: Bool) {
        techMonManager.vanishAnimation(imageView: vanishImage)
        techMonManager.stopBGM()
        gameTimer.invalidate()
        isPlayerAttackAvailable = false
        
        var finishMessage: String = ""
        if isPlayerWin {
            techMonManager.playSE(fileName: "SE_fanfare")
            finishMessage = "勇者の勝利！"
        } else {
            techMonManager.playSE(fileName: "SE_gameover")
            finishMessage = "勇者の敗北..."
        }
        
        let alert = UIAlertController(title: "バトル終了", message: finishMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.dismiss(animated: true, completion: nil)}))
        techMonManager.resetStatus()
        present(alert, animated: true, completion: nil)
    }
    
    func updateUI() {
        
        playerHPLabel.text = "\(player.currentHP) / \(player.maxHP)"
        playerMPLabel.text = "\(player.currentMP) / \(player.maxMP)"
        playerTPLabel.text = "\(player.currentTP) / \(player.maxTP)"

        
        enemyHPLabel.text = "\(enemy.currentHP) / \(enemy.maxHP)"
        enemyMPLabel.text = "\(enemy.currentMP) / \(enemy.maxMP)"
        
    }
    
    func judgeBattle() {
        if player.currentHP <= 0 {
            finishBattle(vanishImage: playerImage, isPlayerWin: false)
        } else if enemy.currentHP <= 0 {
            finishBattle(vanishImage: enemyImage, isPlayerWin: true)
        }
    }
    
    @IBAction func attackAction() {
        if isPlayerAttackAvailable {
            techMonManager.damageAnimation(imageView: enemyImage)
            techMonManager.playSE(fileName: "SE_attack")
            enemy.currentHP -= player.attackPoint
            player.currentTP += 10
            if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
            updateUI()
            judgeBattle()
        }
    }
    
    @IBAction func tameruAction() {
        if isPlayerAttackAvailable {
            techMonManager.playSE(fileName: "SE_charge")
            player.currentTP += 40
            if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
        }
    }
    
    @IBAction func fireAction() {
        if isPlayerAttackAvailable && player.currentTP >= 40 {
            techMonManager.damageAnimation(imageView: enemyImage)
            techMonManager.playSE(fileName: "SE_fire")
            
            enemy.currentHP -= 100
            player.currentTP -= 40
            if player.currentTP <= 0 {
                player.currentTP = 0
            }
            player.currentMP = 0
            judgeBattle()
        }
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


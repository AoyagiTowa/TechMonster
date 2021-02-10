//
//  ViewController.swift
//  TechMonster
//
//  Created by Towa Aoyagi on 2021/02/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var staminaLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    var stamina: Int = 100
    var staminaTimer: Timer!
    
    let techMonManager = TechMonManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina)/100"
        
        staminaTimer = Timer.scheduledTimer(timeInterval: 3,
                                            target: self,
                                            selector: #selector(updateStaminaValue),
                                            userInfo: nil,
                                            repeats: true)
        staminaTimer.fire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "lobby")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }

    @IBAction func toBattle() {
        if stamina >= 50 {
            stamina -= 50
            staminaLabel.text = "\(stamina)/100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        } else {
            let alert = UIAlertController(
                title: "バトルに行けない！", message: "スタミナを貯めよう！", preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func updateStaminaValue() {
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina)/100"
        }
    }
    
}


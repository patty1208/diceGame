//
//  ViewController.swift
//  diceGame
//
//  Created by 林佩柔 on 2021/2/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var dice1ImageView: UIImageView!
    @IBOutlet weak var dice2ImageView: UIImageView!
    @IBOutlet weak var dice3ImageView: UIImageView!
    @IBOutlet weak var dice4ImageView: UIImageView!
    @IBOutlet weak var dice5ImageView: UIImageView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var shakeDiceButton: UIButton!
    @IBOutlet weak var diceCupAll: UIImageView!
    
    @IBOutlet weak var checkDiceSwitch: UISwitch!
    @IBOutlet weak var diceCupTop: UIImageView!
    
    @IBOutlet weak var openDiceButton: UIButton!
    
    @IBOutlet weak var checkSwitchBackground: UIView!
    var state: String = "搖骰前"
    var player: AVPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkDiceSwitch.isEnabled = false
        openDiceButton.isEnabled = false
        
        resetButton.layer.cornerRadius = 10
        shakeDiceButton.layer.cornerRadius = 10
        openDiceButton.layer.cornerRadius = 10
        checkSwitchBackground.layer.cornerRadius = 10
        
        buttonStateChangeColor(sender: openDiceButton)
        switchStateChangeColor(sender: checkDiceSwitch)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if state == "請搖骰"{
                if let url = Bundle.main.url(forResource: "diceShakeSoundEffect", withExtension: "mp3") {
                    player = AVPlayer(url: url)
                    player?.play()
                }
                state = "鎖定"
                randomDice()
                shakeDiceButton.setTitle(" locked ", for: .disabled)
                checkDiceSwitch.isEnabled = true
                openDiceButton.isEnabled = true
                
                buttonStateChangeColor(sender: shakeDiceButton)
                buttonStateChangeColor(sender: openDiceButton)
                switchStateChangeColor(sender: checkDiceSwitch)
                
            }
        }
    }
    
    func randomDice(){
        let diceArray = [dice1ImageView, dice2ImageView, dice3ImageView, dice4ImageView, dice5ImageView]
        for i in diceArray{
            let randonNumber = Int.random(in: 1...6)
            i?.image = UIImage(named: "dice_" + String(randonNumber))
        }
    }
    func buttonStateChangeColor(sender: UIButton){
        if sender.isEnabled == false{
            sender.backgroundColor = UIColor(red: 241/255, green: 211/255, blue: 2/255, alpha: 0.2)
            sender.setTitleColor(UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 0.8), for: .disabled)
        } else if sender.isEnabled == true{
            sender.backgroundColor = UIColor(red: 241/255, green: 211/255, blue: 2/255, alpha: 1)
            sender.setTitleColor(UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1), for: .normal)
        }
    }
    
    func switchStateChangeColor(sender: UISwitch){
        if sender.isEnabled == false{
            checkSwitchBackground.backgroundColor = UIColor(red: 241/255, green: 211/255, blue: 2/255, alpha: 0.2)
            
        } else if sender.isEnabled == true{
            checkSwitchBackground.backgroundColor = UIColor(red: 241/255, green: 211/255, blue: 2/255, alpha: 1)
        }
    }
    
//    @IBAction func buttonPressed(_ sender: Any) {
//        if let url = Bundle.main.url(forResource: "diceShakeSoundEffect", withExtension: "mp3") {
//            player = AVPlayer(url: url)
//            player?.play()
//        }
//
//    }
    
    @IBAction func shakeDice(_ sender: UIButton) {
        sender.setTitle(" shake it", for: .disabled)
        sender.isEnabled = false
        state = "請搖骰"
        buttonStateChangeColor(sender: shakeDiceButton)
        print(shakeDiceButton.state)
    }
    
    @IBAction func checkDiceSwitch(_ sender: UISwitch) {
        if state == "鎖定"{
            if sender.isOn == true{
                diceCupAll.isHidden = true
                diceCupTop.alpha = 0.8
            } else {
                diceCupAll.isHidden = false
            }
        } else {
            sender.isEnabled = false
        }
    }
    @IBAction func openDiceCup(_ sender: UIButton) {
        if state == "鎖定"{
            diceCupAll.isHidden = true
            diceCupTop.alpha = 1
            checkDiceSwitch.isEnabled = false
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, animations: {
                self.diceCupTop.frame = CGRect(x: 39, y: -150, width: 257, height: 299)
            }, completion: nil)
            openDiceButton.isEnabled = false
            buttonStateChangeColor(sender: openDiceButton)
            switchStateChangeColor(sender: checkDiceSwitch)
        } else {
            sender.isEnabled = false
            buttonStateChangeColor(sender: openDiceButton)
        }
        sender.isEnabled = false
        buttonStateChangeColor(sender: openDiceButton)
    }
    
    @IBAction func resetDiceButton(_ sender: UIButton) {
        
        randomDice()
        
        state = "搖骰前"
        
        diceCupAll.isHidden = false
        diceCupTop.frame = CGRect(x: 39, y: 43, width: 257, height: 299)
        
        shakeDiceButton.isEnabled = true
        shakeDiceButton.setTitle(" play", for: .normal)
        
        checkDiceSwitch.isEnabled = false
        checkDiceSwitch.isOn = false
        
        openDiceButton.isEnabled = false
        
        buttonStateChangeColor(sender: shakeDiceButton)
        buttonStateChangeColor(sender: openDiceButton)
        switchStateChangeColor(sender: checkDiceSwitch)
        print(shakeDiceButton.state)
        
        
        
    }
    
}

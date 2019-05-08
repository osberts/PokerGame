//
//  ViewController.swift
//  PokerGame
//
//  Created by User21 on 2019/5/2.
//  Copyright © 2019 app. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var addLabel: UILabel!
    
    var step  = 0
    var grade = 0
    var counter = 30.00
    var timer = Timer()
    var isPlaying = false

    var frontButton: UIButton?
    
    /// 所有按钮
    @IBOutlet var buttons: [UIButton]!
    
    /// 所有匹配的按钮
    var matchedButtons = [UIButton]()
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(counter)
        setupTitle()
        
        game = Game()
        reSetPoker()
        
        addLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    func setupTitle() {
        self.title = "紙牌對對碰"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionForAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(actionForReStart))
    }
    
    
    @IBAction func srartTimer(_ sender: UIButton) {
        if(isPlaying) {
            return
        }
        startButton.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    @objc func UpdateTimer() {
        counter = counter - 0.1
        
        if Float(counter) == -1.5740187e-13{
            startButton.isEnabled = true
            timer.invalidate()
            isPlaying = false
            let controller = UIAlertController(title: "You lose QQ", message: "回家練練再來吧！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(okAction)
            present(controller, animated: true, completion: nil)
        }
        timeLabel.text = String(format: "%.1f", counter)

    }
    

    @objc func actionForAction() {
 
        let leftButtons = self.buttons.filter { self.matchedButtons.contains($0) == false }

        var cards = [Card]()
        var string = ""
        for button in leftButtons {
            let card = self.game.actionCards[self.buttons.firstIndex(of: button)!]
            if  card.isDrawed == false {
                continue
            }
            cards.append(card)
            string += card.size + card.suit + "\n"
        }
        
        let alter = UIAlertController(title: nil, message: "剩餘未匹配花色：\n\(string)", preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default, handler: nil)
        alter.addAction(action)
        self.present(alter, animated: true, completion: nil)
    }
    
    @objc func actionForReStart() {
        game.reStart()
        reSetPoker()
    }
    
    func reSetPoker() {
        if let button = self.frontButton {
            button.changeToNormal()
        }
        
        for i in 0..<buttons.count {
            let button = buttons[i]
            let card = game.actionCards[i]
            card.isMatched = false
            card.isDrawed = false
            button.setTitle(card.size + " " + card.suit, for: .selected)
        }
        
        let _ = self.matchedButtons.map { button in
            button.changeToNormal()
            return
        }
        startButton.isEnabled = true
        timer.invalidate()
        isPlaying = false
        counter = 30.00
        timeLabel.text = String(counter)
        self.step = 0
        self.grade = 0
        self.stepLabel.text = "0"
        self.gradeLabel.text = "0"
        frontButton = nil
        self.matchedButtons.removeAll()
        
    }
    
// MARK:翻牌操作
    @IBAction func actionForDraw(_ sender: UIButton) {
        let index = self.buttons.firstIndex(of: sender)!
        let card = game.actionCards[index]
        card.isDrawed = true
        
        if card.isMatched == true {
            return
        }
        
        UIView.transition(with: sender, duration: 0.35, options: .transitionFlipFromLeft, animations: { 
            sender.setBackgroundImage(UIImage(named:"bg_poker_front"), for: .normal)
            sender.setTitle(card.size + " " + card.suit, for: .normal)
        }) { (finished) in
            if finished == true {
                self.step += 1
                self.stepLabel.text = String(self.step)
                var grade = 0
                
                if self.frontButton != nil {
                    let front = self.frontButton!.title(for: .normal)
                    let back = sender.title(for: .normal)
                    let frontIndex = self.buttons.firstIndex(of: self.frontButton!)!
                    let frontCard = self.game.actionCards[frontIndex]
                    
                    grade = front!.compare(back)
                    if grade == 0 {
                        // 把前一张牌变回来
                        self.frontButton!.changeToNormal()
                        self.frontButton = sender
                    } else {
                        // 加分
                        self.addGradeEffect(grade: grade)
                        
                        frontCard.isMatched = true
                        card.isMatched = true
                        self.grade += grade
                        var sum = self.grade - self.step
                        self.gradeLabel.text = String(self.grade)
                        self.matchedButtons.append(sender)
                        self.matchedButtons.append(self.frontButton!)
                        
                        self.frontButton = nil
                        if self.gradeLabel.text == "110"{
                            self.startButton.isEnabled = true
                            self.timer.invalidate()
                            self.isPlaying = false
                            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "second") as? record {
                                controller.nameText = (String(sum))
                                self.present(controller, animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    self.frontButton = sender
                }
            }
        }
    }
    
    func addGradeEffect(grade: Int) {
        self.addLabel.text = "+" + String(grade)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.addLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (finish) in
            UIView.animate(withDuration: 0.3, animations: { 
                self.addLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
            })
        }
    }
}


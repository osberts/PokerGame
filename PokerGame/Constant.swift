//
//  Constant.swift
//  PokerGame
//
//  Created by User21 on 2019/5/2.
//  Copyright © 2019 app. All rights reserved.
//


import UIKit

extension String {
    @discardableResult
    func compare(_ suit: String?) -> Int {
        
        let front = self.components(separatedBy: " ")
        let suited = suit?.components(separatedBy: " ")
        print(front, suited)
        var grade = 0
        if front[0] == suited?[0] {
            grade += 22
        } else {
            grade += 0
        }
        return grade
    }
}

extension UIButton {
    func changeToNormal() {
        UIView.transition(with: self, duration: 0.35, options: .transitionFlipFromLeft, animations: { 
            self.setBackgroundImage(UIImage(named:"bg_poker_back"), for: .normal)
            self.setTitle(nil, for: .normal)
        }, completion: nil)
    }
}

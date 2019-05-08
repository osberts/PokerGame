//
//  Card.swift
//  PokerGame
//
//  Created by User21 on 2019/5/2.
//  Copyright © 2019 app. All rights reserved.
//

import UIKit

/// 單張
class Card {
    
    /// 大小
    var size: String
    
    /// 花色
    var suit: String
    
    var isMatched = false
    
    var isDrawed = false
    
    init(size: String, suit: String) {
        self.size = size
        self.suit = suit
    }
    
    ///
    /// - Returns: 所有大小的集合
    static func allSize() -> [String] {
        return ["2",
                "3",
                "4",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
                "J",
                "Q",
                "K",
                "A"]
    }
    
    ///
    /// - Returns: 所有花色的集合
    static func allSuit() -> [String] {
        return ["♠️",
                "♣️",
                "♥️",
                "♦️"]
    }
}

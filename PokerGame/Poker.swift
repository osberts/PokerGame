//
//  Poker.swift
//  PokerGame
//
//  Created by User21 on 2019/5/2.
//  Copyright © 2019 app. All rights reserved.
//

import UIKit


struct Poker {
    let count: UInt32 = 52
    var cards = [Card]()
    
    init() {
        let allSize = Card.allSize()
        let allSuit = Card.allSuit()
        
        for size in allSize {
            for suit in allSuit {
                let card = Card(size: size, suit: suit)
                cards.append(card)
            }
        }
        
    }
}

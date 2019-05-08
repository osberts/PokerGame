//
//  Game.swift
//  PokerGame
//
//  Created by User21 on 2019/5/2.
//  Copyright © 2019 app. All rights reserved.
//

import UIKit

struct Game {
    var actionCards = [Card]()
    let poker: Poker
    
    init() {
        poker = Poker()
        reStart()
    }

    mutating func reStart() {
        if actionCards.count != 0 {
            actionCards.removeAll()
        }
        var cards = poker.cards //整副牌
        for _ in 0..<5 {
            let index = Int(arc4random() % UInt32(cards.count))
            let card = cards[index]//抽出來的卡
            var pair = card
            cards.remove(at: index)
            for i in 0..<52{
                if cards[i].size == card.size{
                    pair = cards[i]
                    cards.remove(at: i)
                    break
                }
            }
   
            actionCards.append(card)
            actionCards.append(pair)
        }
        actionCards = actionCards.shuffled()
    }
    
}

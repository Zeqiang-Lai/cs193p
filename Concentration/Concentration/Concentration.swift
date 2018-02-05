//
//  Concentration.swift
//  Concentration
//
//  Created by Zeqiang on 2018/1/13.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var lastFlipTime = Date()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isFaceUp , !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                let thisFlipTime = Date()
                let flipInterval = thisFlipTime.timeIntervalSince(lastFlipTime)
                lastFlipTime = thisFlipTime
                
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Int(12 / (flipInterval+1))  // extra credit item 2
                } else {
                    if cards[index].isSeen {
                        score -= Int((5+flipInterval) / 5)  // extra credit item 2
                    }
                    if cards[matchIndex].isSeen {
                        score -= Int((5+flipInterval) / 5)
                    }
                }
                cards[index].isSeen = true
                cards[matchIndex].isSeen = true
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        // Shuffe the cards
        for index in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(index, randomIndex)
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

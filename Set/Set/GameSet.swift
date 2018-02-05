//
//  GameSet.swift
//  Set
//
//  Created by Zeqiang on 2018/1/19.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

struct GameSet
{
    private(set) var deck = [Card]()
    private(set) var players = [Player]()
    private(set) var cardsOnTable = [Card]()
    private(set) var cardsSelected = [Int]()
    
    let numberOfCards = 81
    let initNumberOfCards = 12
    
    init(numberOfPlayers: Int){
        for _ in 0..<numberOfPlayers {
            players += [Player()]
        }
        for _ in 0..<numberOfCards {
            deck += [Card()]
        }
        for _ in 0..<initNumberOfCards {
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            cardsOnTable += [deck.remove(at: randomIndex)]
        }
    }
    
    mutating func chooseCard(at cardNumber: Int, who player: Int){
        if cardNumber >= cardsOnTable.count {
            return
        }
        // 如果选中3张卡，则取消选中，并判断是否match，若match，换成新牌
        if cardsSelected.count == 3 {
            for index in cardsSelected.indices {
                cardsOnTable[cardsSelected[index]].isSelect = false
                if cardsOnTable[cardsSelected[index]].isMatch == true {
                    cardsOnTable[cardsSelected[index]].isAppear = false
                    if let card = getOneCardFromDeck() {
                        cardsOnTable[cardsSelected[index]] = card
                    }
                }
            }
            cardsSelected.removeAll()
        } else {
            // 点两次，取消选中
            if cardsSelected.contains(cardNumber) {
                cardsOnTable[cardNumber].isSelect = false
                cardsSelected.remove(at: cardsSelected.index(of: cardNumber)!)
                return
            }
        }
    
        cardsOnTable[cardNumber].isSelect = true
        cardsSelected += [cardNumber]
        if cardsSelected.count == 3 {
            if isSet(at: cardsSelected) {
                for index in cardsSelected.indices {
                    cardsOnTable[cardsSelected[index]].isMatch = true
                }
                // TODO: reward
                players[player].score += 1
            } else {
                // TODO: penalty
                players[player].score -= 1
            }
        }
        
    }
    
    mutating func deal3MoreCard(isAddNew:Bool) {
        if isAddNew && cardsOnTable.count < initNumberOfCards * 2{
            for _ in 0..<3 {
                if let card = getOneCardFromDeck() {
                    cardsOnTable += [card]
                }
            }
            return
        }
        for index in cardsSelected.indices {
            if let card = getOneCardFromDeck() {
                cardsOnTable[cardsSelected[index]] = card
            }
        }
    }
    
    mutating func getOneCardFromDeck() -> Card? {
        if deck.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
            return deck.remove(at: randomIndex)
        } else {
            return nil
        }
    }
    
    func isSet(at cards: [Int]) -> Bool {
        var isSet = true
        for indexOfFeature in 0..<Card.numberOfFeatures{
            var diffFeature = Set<Int>()
            for indexOfCard in cards.indices {
                diffFeature.insert(cardsOnTable[cards[indexOfCard]].features[indexOfFeature])
            }
            if diffFeature.count != 1 && diffFeature.count != Card.numberOfFeatures {
                isSet = false
            }
        }
        return isSet
    }
}

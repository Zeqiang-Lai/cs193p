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
    private(set) var cardsSelected = [Card]()
    
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
    
    mutating func chooseCard(at originCardNumber: Int, who player: Int){
        let cardChoosen = cardsOnTable[originCardNumber]
        // 如果选中3张卡，则取消选中，并判断是否match，若match，换成新牌
        if cardsSelected.count == 3 {
            for card in cardsSelected {
               card.isSelect = false
                if card.isMatch == true {
                    if let newCard = getOneCardFromDeck() {
                        cardsOnTable[cardsOnTable.index(of: card)!] = newCard
                    } else {
                        cardsOnTable.remove(at: cardsOnTable.index(of: card)!)
                    }
                }
            }
            cardsSelected.removeAll()
        } else {
            // 点两次，取消选中
            if cardsSelected.contains(cardChoosen) {
                cardChoosen.isSelect = false
                cardsSelected.remove(at: cardsSelected.index(of: cardChoosen)!)
                return
            }
        }
        if let cardNumber = cardsOnTable.index(of: cardChoosen) {
            cardsOnTable[cardNumber].isSelect = true
            cardsSelected += [cardChoosen]
            if cardsSelected.count == 3 {
                if isSet(at: cardsSelected) {
                    for card in cardsSelected {
                        cardsOnTable[cardsOnTable.index(of: card)!].isMatch = true
                    }
                    // TODO: reward
                    players[player].score += 1
                } else {
                    // TODO: penalty
                    players[player].score -= 1
                }
            }
        }
    }
    
    mutating func deal3MoreCard(isAddNew:Bool) {
        if isAddNew && cardsOnTable.count < numberOfCards{
            for _ in 0..<3 {
                if let card = getOneCardFromDeck() {
                    cardsOnTable += [card]
                }
            }
            return
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
    
    mutating func shuffle() {
        for index in 0..<cardsOnTable.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cardsOnTable.count)))
            cardsOnTable.swapAt(index, randomIndex)
        }
    }
    
    func isSet(at cards: [Card]) -> Bool {
        var isSet = true
        for indexOfFeature in 0..<Card.numberOfFeatures{
            var diffFeature = Set<Int>()
            for card in cards {
                diffFeature.insert(cardsOnTable[cardsOnTable.index(of: card)!].features[indexOfFeature])
            }
            if diffFeature.count != 1 && diffFeature.count != Card.numberOfFeatures {
                isSet = false
            }
        }
        return isSet
    }
}

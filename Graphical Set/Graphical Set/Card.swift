//
//  Card.swift
//  Set
//
//  Created by Zeqiang on 2018/1/17.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

class Card:Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var features = [Int]()
    var isSelect = false
    var isMatch = false
    let identifier: Int
    
    static let numberOfFeatures = 4
    static var identifierFactory = -1
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
        var id = identifier, divider = 3
        for _ in 0..<Card.numberOfFeatures {
            features.append(id % divider)
            id /= 3
        }
    }
}

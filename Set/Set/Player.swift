//
//  Player.swift
//  Set
//
//  Created by Zeqiang on 2018/1/17.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

struct Player {
    private let identifier: Int
    var score = 0
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Player.getUniqueIdentifier()
    }
}

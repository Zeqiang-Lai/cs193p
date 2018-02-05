//
//  GameThemes.swift
//  Concentration
//
//  Created by Zeqiang on 2018/1/15.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation
import UIKit

class GameThemes
{
    var backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    var textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    var emojiChoices = "🏐⚽️🏓🏀🎱🎾⚾️🏈"
    let emojiThemesNum = 6
    
    init(){
        let theme = Int(arc4random_uniform(UInt32(emojiThemesNum)))
        switch theme {
        case 0:
            emojiChoices = "🏐⚽️🏓🏀🎱🎾⚾️🏈" // sport
            backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        case 1:
            emojiChoices = "🚗🚕🚑🚛🚲🛵🚍🏎" // car
            backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 2:
            emojiChoices = "1️⃣8️⃣9️⃣5️⃣0️⃣4️⃣🔟3️⃣" // number
            backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case 3:
            emojiChoices = "🇩🇪🇩🇴🇮🇸🇸🇿🇨🇷🇫🇮🇬🇩🇬🇲" // flag
            backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            textColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case 4:
            emojiChoices = "🌚🌝🌞🌜🌛🌕🌘🌒" // moon
            backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cardBackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 5:
            emojiChoices = "🦌🐂🐢🦍🦐🦄🐟🦒" // animal
            backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        default:
            emojiChoices = "🏐⚽️🏓🏀🎱🎾⚾️🏈" // sport
            backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        
    }
}


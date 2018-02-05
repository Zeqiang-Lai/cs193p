//
//  ViewController.swift
//  Concentration
//
//  Created by Zeqiang on 2018/1/13.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy private var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var theme = GameThemes()
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak private var flipCountLabel: UILabel!
    @IBOutlet weak private var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = GameThemes()
        
        emojiChoices = theme.emojiChoices
        emojis = [Card : String]()
        
        // Extra Credit Item 1
        scoreLabel.textColor = theme.textColor
        flipCountLabel.textColor = theme.textColor
        newGameButton.setTitleColor(theme.textColor, for: UIControlState.normal)
        
        view.backgroundColor = theme.backgroundColor
        
        updateViewFromModel()
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
       viewDidLoad()
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Doesn't found button in flipButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme.cardBackColor
            }
        }
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)    
        ]
        let attributedString = NSAttributedString(string: "FLIPS: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        scoreLabel.text = "SCORE: \(game.score)"
    }
    
    private var emojiChoices = "🏐⚽️🏓🏀🎱🎾⚾️🏈"
    
    private var emojis = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        if emojis[card] == nil , emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojis[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojis[card] ?? "?"
    }

}

extension Int {
    var arc4random:Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

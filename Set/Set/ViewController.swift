//
//  ViewController.swift
//  Set
//
//  Created by Zeqiang on 2018/1/17.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var game = GameSet(numberOfPlayers: 1)
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cardsInDeckLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber, who: 0)
            updateFrameFromModel()
        } else {
            print("No button founded in cardButtons")
        }
    }
   
    @IBAction func deal3MoreCard(_ sender: UIButton) {
        var isAddNew = true
//        for index in game.cardsSelected.indices {
//            if !game.cardsOnTable[game.cardsSelected[index]].isMatch {
//                isAddNew = true
//                break
//            }
//        }
        game.deal3MoreCard(isAddNew: isAddNew)
        updateFrameFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        startNewGame()
    }
    
    override func viewDidLoad() {
        startNewGame()
    }
    
    func startNewGame() {
        for button in cardButtons {
            button.isHidden = false
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.layer.borderWidth = 0
            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControlState.normal)
            button.setAttributedTitle(nil, for: UIControlState.normal)
        }
        game = GameSet(numberOfPlayers: 1)
        updateFrameFromModel()
    }
    
    func updateFrameFromModel() {
        for index in game.cardsOnTable.indices {
            let card = game.cardsOnTable[index]
            if !card.isAppear {
                cardButtons[index].isHidden = true
            } else {
                if card.isSelect {
                    if card.isMatch {
                        cardButtons[index].layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    } else {
                        if game.cardsSelected.count == 3{
                            cardButtons[index].layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                        } else {
                            cardButtons[index].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        }
                    }
                } else {
                    cardButtons[index].layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                cardButtons[index].setAttributedTitle(getAttributedString(of: card.features), for: UIControlState.normal)
                cardButtons[index].layer.borderWidth = 2
                cardButtons[index].layer.cornerRadius = 8.0
            }
        }
        scoreLabel.text = "SCORE: \(game.players[0].score)"
        cardsInDeckLabel.text = "Cards in Deck: \(game.deck.count)"
    }
    
    func getAttributedString(of features: [Int]) -> NSAttributedString{
        var str = ""
        for _ in 0..<features[0]+1 {
            str += shapes[features[1]]
        }
        let color = colors[features[2]].withAlphaComponent(CGFloat(alphas[features[3]]))
        let attributes: [NSAttributedStringKey:Any] = [
            .foregroundColor: color,
            .strokeWidth: strokeWidths[features[3]],
            .strokeColor: colors[features[2]],
        ]
        
        return NSAttributedString(string: str, attributes: attributes)
    }
    /*
     features
     1.number
     2.shape
     3.color
     4.shading
     */
    let shapes = ["▲","●","■"]
    let colors = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
    let strokeWidths = [-1,-1,8]
    let alphas = [1,0.15,0]
}


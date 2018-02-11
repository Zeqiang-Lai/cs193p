//
//  ViewController.swift
//  Graphical Set
//
//  Created by Zeqiang on 2018/2/5.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var game = GameSet(numberOfPlayers: 1)
    var cardViews = [SetCardView]()
    lazy var grid = Grid(layout: Grid.Layout.aspectRatio(0.63), frame: cardDeckView.bounds)
    
    @IBOutlet weak var cardDeckView: UIView! {
        didSet {
            let rotationGestureRecognizer = UIRotationGestureRecognizer(
                target: self, action: #selector(ViewController.rotateDeck(recognizer:)))
            let swipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(ViewController.swipeDownDeck(recognizer:)))
            swipeGestureRecognizer.direction = .down
            swipeGestureRecognizer.numberOfTouchesRequired = 2
            cardDeckView.addGestureRecognizer(rotationGestureRecognizer)
            cardDeckView.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberOfLeftCardLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        grid.frame = cardDeckView.bounds
        startNewGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        grid.frame = cardDeckView.bounds
        updateFrameFromModel()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        newGameButton.setTitle(traitCollection.verticalSizeClass == .compact ? "NEW" : "NEW GAME", for: .normal)
    }
    
    @IBAction func deal3MoreCard(_ sender: UIButton) {
        let isAddNew = true
        game.deal3MoreCard(isAddNew: isAddNew)
        updateFrameFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        startNewGame()
    }
    
    private func updateDeckView() {
        let ix2Color = [SetCardView.Color.green, SetCardView.Color.red, SetCardView.Color.purple]
        let ix2Number = [SetCardView.Number.one, SetCardView.Number.two, SetCardView.Number.three]
        let ix2Shape = [SetCardView.Shape.diamonds, SetCardView.Shape.ovals, SetCardView.Shape.squiggles]
        let ix2Shading = [SetCardView.Shading.outlined, SetCardView.Shading.solid, SetCardView.Shading.striped]
        
        for view in cardDeckView.subviews {
            view.removeFromSuperview()
        }
        cardViews.removeAll()
        grid.cellCount = game.cardsOnTable.count
        
        for i in 0..<game.cardsOnTable.count {
            let cardView = SetCardView()
            cardView.color = ix2Color[game.cardsOnTable[i].features[0]]
            cardView.number = ix2Number[game.cardsOnTable[i].features[1]]
            cardView.shape = ix2Shape[game.cardsOnTable[i].features[2]]
            cardView.shading = ix2Shading[game.cardsOnTable[i].features[3]]
            cardView.backgroundColor = UIColor.white
            cardView.frame = grid[i]!.insetBy(dx: CGFloat(8), dy: CGFloat(10))
            cardDeckView.addSubview(cardView)
            cardViews += [cardView]
            
            cardView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(ViewController.tap(recognizer:)))
            cardView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    func startNewGame() {
        game = GameSet(numberOfPlayers: 1)
        updateDeckView()
        updateFrameFromModel()
    }
    
    @objc func tap(recognizer: UITapGestureRecognizer) {
        if let cardNumber = cardViews.index(of: recognizer.view as! SetCardView) {
            game.chooseCard(at: cardNumber, who: 0)
            updateFrameFromModel()
        } else {
            print("No button founded in cardButtons")
        }
    }
    
    @objc func rotateDeck(recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            game.shuffle()
            updateFrameFromModel()
        default:
            break
        }
    }
    
    @objc func swipeDownDeck(recognizer: UISwipeGestureRecognizer) {
        game.deal3MoreCard(isAddNew: true)
        updateFrameFromModel()
    }
    
    func updateFrameFromModel() {
        updateDeckView()
        numberOfLeftCardLabel.text = "DECK: \(game.deck.count)"
        scoreLabel.text = "SCORE: \(game.players[0].score)"
        for index in game.cardsOnTable.indices {
            let card = game.cardsOnTable[index]
            if card.isSelect {
                cardViews[index].isSelected = true
                if card.isMatch {
                    cardViews[index].borderColor = UIColor.green
                } else {
                    if game.cardsSelected.count == 3{
                        cardViews[index].borderColor = UIColor.red
                    } else {
                        cardViews[index].borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    }
                }
            } else {
                cardViews[index].isSelected = false
            }
        }
    }
    
}

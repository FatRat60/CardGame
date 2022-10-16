//
//  Card.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/15/22.
//

import Foundation
import SpriteKit

enum CardSuite :Int {
    case clubs,
         spades,
         hearts,
         diamond
}

class Card : SKSpriteNode {
    let cardSuite :CardSuite
    let cardNum :String
    let frontText :SKTexture
    let backText :SKTexture
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardSuite :CardSuite, cardNum :String) {
        self.cardSuite = cardSuite
        self.cardNum = cardNum
        self.backText = SKTexture(imageNamed: "CardBack")
        var frontName :String
        switch cardSuite {
        case .clubs:
            frontName = "C"
        case .spades:
            frontName = "S"
        case .hearts:
            frontName = "H"
        case .diamond:
            frontName = "D"
        }
        self.frontText = SKTexture(imageNamed: frontName + cardNum)
        super.init(texture: frontText, color: .clear, size: frontText.size())
    }
}

//
//  Card.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/15/22.
//

import Foundation
import SpriteKit

enum CardSuite :Int, CaseIterable {
    case clubs,
         spades,
         hearts,
         diamond
}

struct Card :Identifiable, Equatable{
    
    let id :Int
    let cardSuite :CardSuite
    let cardNum :String
    let frontText :String
    let backText :String
    var currText :String
    var faceUp: Bool
    
    init(cardSuite :CardSuite, cardNum :String, deckType: String) {
        self.cardSuite = cardSuite
        self.backText = "cardBack"
        self.id = Int(cardNum)! + (cardSuite.rawValue * 13)
        var frontName :String
        switch cardSuite {
        case .clubs:
            frontName = "1"
        case .spades:
            frontName = "2"
        case .hearts:
            frontName = "4"
        case .diamond:
            frontName = "8"
        }
        // Add deckType + "_" before when u get the card files on your computer
        self.frontText = deckType + "/" + cardNum + frontName
        if (Int(cardNum) ?? 0 > 10) {self.cardNum = "10"}
        else {self.cardNum = cardNum}
        self.currText = self.frontText
        self.faceUp = false
    }
    
    mutating func flip() {
        
        if faceUp {
            self.currText = self.backText
        } else {
            self.currText = self.frontText
        }
        faceUp = !faceUp
    }
}

class Player {
    let name :String
    var money :Int
    @Published var hand :[Card]
    
    init(name :String, money :Int) {
        self.name = name
        self.money = money
        self.hand = [Card]()
    }
    
    init() {
        self.name = "Dealer"
        self.money = 0
        self.hand = [Card]()
    }
    
    func sumHand() -> Int{
        var cnt = 0
        for card in self.hand{
            let val = Int(card.cardNum) ?? 0
            if (val == 1 && cnt + 11 <= 21){
                cnt += 11
            }
            else{cnt += val}
        }
        return cnt
    }
}

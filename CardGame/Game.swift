//
//  Game.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/15/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var players:[Player]!
    var selDeck:String!
    var numPlayers:Int!
    var deck:[Card]!
    
    override func didMove(to view: SKView) {
        // Load in data passed from view
        players = [Player]()
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
                
        if let dictUser = self.userData?.value(forKey: "user") as? User {
            players[0] = Player(name: dictUser.displayName, money: dictUser.money)
            for i in 1...numPlayers-1 {
                players[i] = Player(name: firstNameList.randomElement()! + lastNameList.randomElement()!, money: (dictUser.money * 3) / 4)
            }
        }
        if let dictDeck = self.userData?.value(forKey: "selDeck") as? String {
            selDeck = dictDeck
        }
        else {selDeck = "Classic"}
        if let dictNum = self.userData?.value(forKey: "numPlayers") as? Int {
            numPlayers = dictNum
        }
        else {numPlayers = 2}
        // Create deck array
        deck = [Card](repeating: Card(cardSuite: .clubs, cardNum: "5", deckType: selDeck), count:54)
        for suit in CardSuite.allCases {
            for i in 1...13 {
                let card: Card = Card(cardSuite: suit, cardNum: String(i), deckType: selDeck)
                deck[(i - 1) + (suit.rawValue * 13)] = card
            }
        }
    }
}

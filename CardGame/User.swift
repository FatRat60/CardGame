//
//  User.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/22/22.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    var username :String
    @Published var displayName :String
    @Published var profile :UIImage
    var money :Int
    var wins :Int
    var gamesPlayed:Int
    var decks :[CardSelect]
    
    init(username :String, displayName :String, profile :String, money :Int, wins :Int, gamesPlayed :Int, decks :[CardSelect]) {
        self.username = username
        self.displayName = displayName
        self.profile = UIImage(data: Data(base64Encoded: profile, options: .ignoreUnknownCharacters)!) ?? UIImage(named: "DefaultPfp")!
        if money > 0 {self.money = money}
        else {self.money = 1000}
        self.gamesPlayed = gamesPlayed
        if wins <= gamesPlayed {self.wins = wins}
        else { self.wins = gamesPlayed }
        self.decks = decks
    }
    
    init(username :String, displayName :String) {
        self.username = username
        self.displayName = displayName
        self.profile = UIImage(named: "defaultPfp")!
        self.money = 5000
        self.wins = 0
        self.gamesPlayed = 0
        self.decks = [CardSelect(id: 1, image: "defaultCard", name: "Classic", price: 1)]
    }
    
    func base64Encode() -> String {
        return (self.profile.jpegData(compressionQuality: 1)?.base64EncodedString())!
    }
    
    func updateName(newName: String)
    {
        self.displayName = newName
        objectWillChange.send()
    }
    
    func changeProfilePic(newPfp: UIImage)
    {
        self.profile = newPfp
        objectWillChange.send()
    }
    
    func logIn(username: String, displayName: String, profile: String, money: Int, wins: Int, gamesPlayed: Int, decks: [CardSelect])
    {
        self.username = username
        self.displayName = displayName
        self.profile = UIImage(data: Data(base64Encoded: profile, options: .ignoreUnknownCharacters)!) ?? UIImage(named: "DefaultPfp")!
        self.money = money
        self.wins = wins
        self.gamesPlayed = gamesPlayed
        self.decks = decks
    }
    
    func logOut()
    {
        self.username = ""
        self.displayName = ""
    }
    
    func win(amount :Int){ self.money += amount }
    func lose(amount :Int){ self.money -= amount }
    func nameChange(newName :String){ self.displayName = newName}
}

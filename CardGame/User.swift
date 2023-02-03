//
//  User.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/22/22.
//

import Foundation

class User: ObservableObject {
    let username :String
    @Published var displayName : String
    var money :Int
    var wins :Int
    var gamesPlayed:Int
    
    init(username :String, displayName :String, money :Int, wins :Int, gamesPlayed :Int) {
        self.username = username
        self.displayName = displayName
        if money > 0 {self.money = money}
        else {self.money = 1000}
        self.gamesPlayed = gamesPlayed
        if wins <= gamesPlayed {self.wins = wins}
        else { self.wins = gamesPlayed }
    }
    
    init(username :String, displayName :String) {
        self.username = username
        self.displayName = displayName
        self.money = 5000
        self.wins = 0
        self.gamesPlayed = 0
    }
    
    func win(amount :Int){ self.money += amount }
    func lose(amount :Int){ self.money -= amount }
    func nameChange(newName :String){ self.displayName = newName}
}

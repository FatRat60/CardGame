//
//  User.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/22/22.
//

import Foundation

class User {
    let username :String
    var displayName : String
    var money :Int
    
    init(username :String, displayName :String, money :Int) {
        self.username = username
        self.displayName = displayName
        if money > 0 {self.money = money}
        else {self.money = 1000}
    }
    
    func win(amount :Int){ self.money += amount }
    func lose(amount :Int){ self.money -= amount }
    func nameChange(newName :String){ self.displayName = newName}
}

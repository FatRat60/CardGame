//
//  CardSelect.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/21/22.
//

import Foundation
import SwiftUI

struct CardSelect: Identifiable, Codable, Hashable {
    var id: Int
    var image: String
    var name: String
    var price: Int
}

let CardSelectList: [CardSelect] = [
    .init(id: 1, image: "defaultCard", name: "Classic", price: 1),
    .init(id: 2, image: "animeCard", name: "Anime", price: 1)]

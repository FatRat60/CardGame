//
//  CardSelect.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/21/22.
//

import Foundation

struct CardSelect: Identifiable, Codable, Hashable {
    var id: Int
    var image: String
    var name: String
}

let CardSelectList: [CardSelect] = [
    .init(id: 1, image: "defaultCard", name: "Classic"),
    .init(id: 2, image: "animeCard", name: "Anime")]

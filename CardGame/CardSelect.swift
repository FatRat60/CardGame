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
    var canPick: Bool
}

let CardSelectList: [CardSelect] = [
    .init(id: 1, image: "defaultCard", name: "Classic", canPick: true),
    .init(id: 2, image: "animeCard", name: "Anime", canPick: false)]

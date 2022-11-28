//
//  SinglePlayerView.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/22/22.
//

import SwiftUI
import SpriteKit

struct SinglePlayerView: View {
    var selDeck: String
    var numPlayers: Int
    var user :User
    
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .fill
        scene.backgroundColor = SKColor.green
        scene.userData = NSMutableDictionary()
        scene.userData?.setObject(user, forKey: "user" as NSCopying)
        scene.userData?.setObject(selDeck, forKey: "selDeck" as NSCopying)
        scene.userData?.setObject(numPlayers, forKey: "numPlayers" as NSCopying)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct SinglePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView(selDeck: "Classic", numPlayers: 4, user: User(username: "Garsh", displayName: "Garsh", money: 102093))
    }
}

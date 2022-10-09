//
//  GameScene.swift
//  CardGame
//
//  Created by Kyle Hultgren on 10/9/22.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let image = UIImage(named: "kokomi")
        var box: SKSpriteNode
        if (image == nil) {
            print("FUCK")
            box = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        }
        else {
            let texture = SKTexture(image: image!)
            box = SKSpriteNode(texture: texture)
            box.scale(to: CGSize(width: 50, height: 70))
        }
        box.position = location
        addChild(box)
    }
}

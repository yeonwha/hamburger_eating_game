//
//  GameScene.swift
//  Lab9_2024
//
//  Created by ICS 224 on 2024-03-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var sprite : SKSpriteNode!
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        sprite = SKSpriteNode(imageNamed: "PlayerSprite")
        sprite.size = CGSize(width: 150, height: 150)
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(sprite)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        sprite.run(SKAction.move(to: pos, duration: 1))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        sprite.run(SKAction.move(to: pos, duration: 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

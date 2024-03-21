//
//  GameScene.swift
//  Lab9_2024
//
//  Created by ICS 224 on 2024-03-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var hitNum: Int = 0
    var label: SKLabelNode!
    
    var sprite : SKSpriteNode!
    var opponentSprite: SKSpriteNode!
    var hitSprite : SKSpriteNode!
    
    let spriteCategory1 : UInt32 = 0b1
    let spriteCategory2 : UInt32 = 0b10
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        /// player's sprite
        sprite = SKSpriteNode(imageNamed: "PlayerSprite")
        sprite.size = CGSize(width: 150, height: 150)
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        
        sprite.physicsBody?.categoryBitMask = spriteCategory1
        sprite.physicsBody?.contactTestBitMask = spriteCategory1
        sprite.physicsBody?.collisionBitMask = spriteCategory1
        
        addChild(sprite)  // add it to the scene
        
        /// sprite attacking player
        opponentSprite = SKSpriteNode(imageNamed: "OpponentSprite")
        opponentSprite.size = CGSize(width: 200, height: 200)
        opponentSprite.position = CGPoint(x: size.width / 2, y: size.height)
        
        opponentSprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        
        opponentSprite.physicsBody?.categoryBitMask = spriteCategory1
        opponentSprite.physicsBody?.contactTestBitMask = spriteCategory1
        opponentSprite.physicsBody?.collisionBitMask = spriteCategory1
        
        addChild(opponentSprite)
        
        label = SKLabelNode()
        label.text = "\(hitNum)"
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
        
        let downMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: 0), duration: 1)
        let upMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height), duration: 1)
        let movement = SKAction.sequence([downMovement, upMovement])
        //opponentSprite.run(SKAction.repeatForever(movement))
        
        self.physicsWorld.contactDelegate = self
        
        moveOpponent()
    }
    
    func moveOpponent(){
        let randomX = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.width))
        let randomY = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height))
        let movement = SKAction.move(to: CGPoint(x: randomX, y: randomY), duration: 1)
        opponentSprite.run(movement, completion: { [unowned self] in
            self.moveOpponent()
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Hit!")
        
//        hitSprite = SKSpriteNode(imageNamed: "HitSprite")
//        hitSprite.size = CGSize(width: 150, height: 150)
//        hitSprite.position = sprite.position
//        addChild(hitSprite)
//        let duration = SKAction.duration(2.0,)
        
        hitNum += 1
        label.text = "\(hitNum)"
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

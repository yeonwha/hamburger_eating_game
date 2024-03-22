//
//  GameScene.swift
//  Lab9_2024
//
//  Created by ICS 224 on 2024-03-13.
//

import SpriteKit
import GameplayKit

let gameOver: Int = -1

class GameScene: SKScene, SKPhysicsContactDelegate {
    var hitNum: Int = 0
    var score: Int = 0
    var label: SKLabelNode!
    var scoreLabel: SKLabelNode!
    
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
        sprite.size = CGSize(width: 170, height: 170)
        sprite.position = CGPoint(x: size.width / 2, y: sprite.size.height)
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        sprite.physicsBody?.restitution = 0.2
        sprite.physicsBody?.isDynamic = false
        
        sprite.physicsBody?.categoryBitMask = spriteCategory1
        sprite.physicsBody?.contactTestBitMask = spriteCategory1
        sprite.physicsBody?.collisionBitMask = spriteCategory1
        
        addChild(sprite)  // add it to the scene
        
        /// sprite attacking player
        opponentSprite = SKSpriteNode(imageNamed: "OpponentSprite")
        opponentSprite.size = CGSize(width: 130, height: 130)
        opponentSprite.position = CGPoint(x: size.width / 2, y: size.height)
        
        opponentSprite.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        opponentSprite.physicsBody?.restitution = 0.8
        
        
        opponentSprite.physicsBody?.categoryBitMask = spriteCategory1
        opponentSprite.physicsBody?.contactTestBitMask = spriteCategory1
        opponentSprite.physicsBody?.collisionBitMask = spriteCategory1
        
        addChild(opponentSprite)
        
//        label = SKLabelNode()
//        label.text = "\(hitNum)"
//        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        addChild(label)
        
        /// score label setting up
        scoreLabel = SKLabelNode()
        scoreLabel.text = "You ate \(score) burger(s)"
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height / 4)
        addChild(scoreLabel)
        
        let downMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: 0), duration: 1)
        let upMovement = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height), duration: 1)
        let movement = SKAction.sequence([downMovement, upMovement])
        //opponentSprite.run(SKAction.repeatForever(movement))
        
        self.physicsWorld.contactDelegate = self
        
        moveOpponent()
    }
    
    func moveOpponent(){
        let randomX = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.width))
        let initialX = Int(opponentSprite.position.x)
        //let randomY = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height))
        let topY = Int(size.height)
        let floorY = 0
        
        let movementDown = SKAction.move(to: CGPoint(x: initialX, y: floorY ), duration: 1.5)
        let movementUp = SKAction.move(to: CGPoint(x: randomX, y: topY ), duration: 0)
        
        //let movement = SKAction.move(to: CGPoint(x: initialX, y: 0), duration: 2)
        let movement = SKAction.sequence([movementDown, movementUp])
        opponentSprite.run(movement, completion: { [unowned self] in
            self.moveOpponent()
            if opponentSprite.position.y < sprite.size.height{
                score -= 0
                scoreLabel.text = "You ate \(score) burger(s)"
            }
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Hit!")
        
//        hitSprite = SKSpriteNode(imageNamed: "HitSprite")
//        hitSprite.size = CGSize(width: 170, height: 170)
//        hitSprite.position = sprite.position
//        addChild(hitSprite)
//        let duration = SKAction.duration(2.0,)
        
//        hitNum += 1
//        label.text = "\(hitNum)"
        
        score += 1
        scoreLabel.text = "You ate \(score) burger(s)"
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

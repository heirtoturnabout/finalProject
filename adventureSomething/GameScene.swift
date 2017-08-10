//
//  GameScene.swift
//  adventureSomething
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Bodytype {
    
    static let None : UInt32 = 0
    static let Door : UInt32 = 1
    static let Enemy : UInt32 = 1
    static let Sword : UInt32 = 2
    static let Hero : UInt32 = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var shouldExit : Bool = false
    var shouldOpen : Bool = false
    var sword : SKSpriteNode = SKSpriteNode()
    var hero = SKSpriteNode(imageNamed: "FFhero_4")
    var isSwordDown : Bool = false
    let castleDoor = SKSpriteNode(imageNamed: "door")
    let doorWall = SKSpriteNode(imageNamed: "doorAndWall")
    let backgroundImage = SKSpriteNode(imageNamed: "floor")
    
    let heroSpeed: CGFloat = 100.0
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        
        
        let xCoord = size.width * 0.5
        let yCoord = size.width * 0.5
        
        hero.size.width = 60
        hero.size.height = 60
        
        castleDoor.size.height = 70
        castleDoor.size.width = 70
        
        backgroundImage.size.height = size.height * 2
        backgroundImage.size.width = size.width * 2
        backgroundImage.zPosition = -1
        
        hero.position = CGPoint (x: xCoord, y: yCoord)
        doorWall.position = CGPoint (x: xCoord, y: yCoord + 400)
        castleDoor.position = CGPoint (x: xCoord, y: yCoord + 450)
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.categoryBitMask = Bodytype.Hero
        hero.physicsBody?.contactTestBitMask = Bodytype.Door
        hero.physicsBody?.collisionBitMask = 0
        
        doorWall.physicsBody = SKPhysicsBody(rectangleOf: doorWall.size, center: CGPoint(x: 0, y: -20))
        doorWall.physicsBody?.isDynamic = false
        doorWall.physicsBody?.categoryBitMask = Bodytype.Door
        doorWall.physicsBody?.contactTestBitMask = Bodytype.Hero
        
        sword.physicsBody = SKPhysicsBody(rectangleOf: sword.size)
        sword.physicsBody?.isDynamic = false
        sword.physicsBody?.categoryBitMask = Bodytype.Sword
        sword.physicsBody?.contactTestBitMask = Bodytype.Door
        
        
        addChild(hero)
        addChild(doorWall)
        addChild(backgroundImage)
        
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let x : CGFloat = 0
        let y : CGFloat = 0
        var vector = CGVector(dx: x, dy: y)
        physicsWorld.gravity = vector
        physicsWorld.contactDelegate = self

    }
    
    func swipedUp (sender: UISwipeGestureRecognizer) {
        var actionMove: SKAction
        
        
        if (hero.position.y + heroSpeed >= size.height) {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: size.height - hero.size.height/2), duration: 0.4)
        }
        else {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.4)
        }
        hero.run(actionMove)
        
    }
    
    func swipedDown (sender: UISwipeGestureRecognizer) {
        var actionMove: SKAction
        
        if (hero.position.y - heroSpeed <= 0){
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.size.height/2), duration: 0.4)
        }
        else {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y - heroSpeed), duration: 0.4)
        }
        hero.run(actionMove)

    }
    
    func swipedLeft (sender: UISwipeGestureRecognizer) {
        var actionMove: SKAction
        
        if (hero.position.x - heroSpeed <= 0) {
            actionMove = SKAction.move(to: CGPoint(x: hero.size.width/2, y: hero.position.y), duration: 0.4)
        }
        else {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x - heroSpeed, y: hero.position.y), duration: 0.4)
        }
        hero.run(actionMove)

    }
    
    func swipedRight (sender: UISwipeGestureRecognizer) {
        var actionMove: SKAction
        
        if (hero.position.x + heroSpeed >= size.width) {
            actionMove = SKAction.move(to: CGPoint(x: size.width - hero.size.width/2, y: hero.position.y), duration :0.4)
        }
        else {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x + heroSpeed, y: hero.position.y), duration: 0.4)
        }
        hero.run(actionMove)

    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      	swordCall()
    }
    
    func removeObject()
    {
        sword.removeFromParent()
        isSwordDown = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func swordCall() {
        if isSwordDown == false
        {
            isSwordDown = true
            sword = SKSpriteNode(imageNamed: "swordUp")
            
            sword.position = CGPoint(x: hero.position.x, y: hero.position.y + 50)
            sword.size.height = 50
            sword.size.width = 50
            
            addChild(sword)
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run(removeObject)])))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyHero = contact.bodyA
        let bodyDoor = contact.bodyB
        let bodySword = contact.bodyA
        
        let contactA = bodyHero.categoryBitMask
        let contactB = bodyDoor.categoryBitMask
        let contactC = bodySword.categoryBitMask
        
        switch contactA {
            
        case Bodytype.Door:
            
            switch contactB {
                case Bodytype.Hero:
                shouldExit = true
                break
                //They Collided
            default:
                
            break
            }
            
        case Bodytype.Hero:
            switch contactB
            {
                case Bodytype.Door:
                shouldExit = true
                break
                
            default:
                
            break
            }
            
            switch contactC {
                
            case Bodytype.Door:
                shouldOpen = true
                break
                
            default:
                
                break
                
            }
            
        default:
            
            break
        }
    }
    
    func isExiting()->Bool
    {
        return shouldExit
    }
    
    func isOpening ->Bool
    {
        return shouldOpen
    }
}

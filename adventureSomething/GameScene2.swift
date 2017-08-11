//
//  GameScene.swift
//  adventureSomething
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var shouldOpen : Bool = false
    var shouldFinal : Bool = false
    var sword : SKSpriteNode = SKSpriteNode()
    var hero = SKSpriteNode(imageNamed: "FFhero_4")
    var isSwordDown : Bool = false
    let doorWall = SKSpriteNode(imageNamed: "doorAndWall")
    let backgroundImage = SKSpriteNode(imageNamed: "floor")
    let treasureChestImage = SKSpriteNode(imageNamed: "treasureChestClosed")
    
    var shouldExit : Bool = false
    
    let heroSpeed: CGFloat = 100.0
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        
        let xCoord = size.width * 0.5
        let yCoord = size.width * 0.5
        
        hero.size.width = 60
        hero.size.height = 60
        
        treasureChestImage.size.height = 70
        treasureChestImage.size.width = 70
        
        backgroundImage.size.height = size.height * 2
        backgroundImage.size.width = size.width * 2
        backgroundImage.zPosition = -1
        
        hero.position = CGPoint (x: xCoord, y: yCoord)
        doorWall.position = CGPoint (x: xCoord, y: yCoord + 400)
        treasureChestImage.position = CGPoint (x: xCoord, y: yCoord + 350)
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.categoryBitMask = Bodytype.Hero
        hero.physicsBody?.contactTestBitMask = Bodytype.Door
        hero.physicsBody?.collisionBitMask = 0
        
        doorWall.physicsBody = SKPhysicsBody(rectangleOf: doorWall.size, center: CGPoint(x: 0, y: -10))
        doorWall.physicsBody?.isDynamic = false
        doorWall.physicsBody?.categoryBitMask = Bodytype.Door
        doorWall.physicsBody?.contactTestBitMask = Bodytype.Sword
        
        treasureChestImage.physicsBody = SKPhysicsBody(rectangleOf: treasureChestImage.size)
        treasureChestImage.physicsBody?.isDynamic = false
        treasureChestImage.physicsBody?.categoryBitMask = Bodytype.TreasureChest
        treasureChestImage.physicsBody?.contactTestBitMask = Bodytype.Hero
        
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
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
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
    
    func removeWall() {
        doorWall.removeFromParent()
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
            sword.size.height = 65
            sword.size.width = 50
            
            sword.physicsBody = SKPhysicsBody(rectangleOf: sword.size)
            sword.physicsBody?.isDynamic = true
            sword.physicsBody?.categoryBitMask = Bodytype.Sword
            sword.physicsBody?.contactTestBitMask = Bodytype.Door
            
            addChild(sword)
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run(removeObject)])))
            shouldExit = true
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyDoor = contact.bodyB
        let bodySword = contact.bodyA
        
        let contactB = bodyDoor.categoryBitMask
        let contactC = bodySword.categoryBitMask
        
        
        switch contactC {
        case Bodytype.Door:
            switch contactB {
            case Bodytype.Sword:
                print("HIT")
                pleaseWork()
                break
                //They Collided
                
            default:
                
                break
            }
            
        case Bodytype.Sword:
            switch contactB
            {
            case Bodytype.Door:
                print("HIT")
                pleaseWork()
                break
                
            default:
                
                break
                
            }
        default:
            
            break
        }
    }
    
    func isExiting()-> Bool
    {
        print (shouldExit)
        return shouldExit
    }
    
    func finalScene() ->Bool
    {
        if shouldOpen == true
        {
            addChild(treasureChestImage)
            removeWall()
        }
        return shouldFinal
    }
    
    func pleaseWork() {
        shouldExit = true
    }
}

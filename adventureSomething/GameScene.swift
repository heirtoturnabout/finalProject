//
//  GameScene.swift
//  adventureSomething
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let heroStanding = SKSpriteNode(imageNamed: "FFhero")
    let heroBackFacingPlayer = SKSpriteNode(imageNamed: "FFhero_4")
    let heroStandingRight = SKSpriteNode(imageNamed: "FFhero_6")
    let heroStandingLeft = SKSpriteNode(imageNamed: "FFhero_2")
    let heroWalkingRight = SKSpriteNode(imageNamed: "FFhero_5")
    let heroWalkingLeft = SKSpriteNode(imageNamed: "FFhero_3")
    
    let castleDoor = SKSpriteNode(imageNamed: "door")
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        backgroundColor = SKColor.gray
        
        let xCoord = size.width * 0.5
        let yCoord = size.width * 0.5
        
        heroStanding.size.width = 60
        heroStanding.size.height = 60
        heroBackFacingPlayer.size.width = 60
        heroBackFacingPlayer.size.height = 60
        heroStandingLeft.size.width = 60
        heroStandingLeft.size.height = 60
        heroStandingRight.size.width = 60
        heroStandingRight.size.height = 60
        heroWalkingLeft.size.width = 60
        heroWalkingRight.size.height = 60
        
        castleDoor.size.height = 70
        castleDoor.size.width = 70
        
        heroBackFacingPlayer.position = CGPoint (x: xCoord, y: yCoord)
        castleDoor.position = CGPoint (x: xCoord, y: yCoord + 400)
        addChild(heroBackFacingPlayer)
        addChild(castleDoor)
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

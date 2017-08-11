//
//  GameViewController2.swift
//  adventureSomething
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameViewController2: UIViewController {
    
    var timer = Timer()
    var scene2 = GameScene2()
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene2 = GameScene2 (size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            scene2.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene2)
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    func updateCounting(){
        if scene2.isExiting()
        {
            switchScene()
        }
    }
    
    func switchScene()
    {
        scene2 = GameScene2()
        performSegue(withIdentifier: "gameToText2", sender: nil)
    }
}

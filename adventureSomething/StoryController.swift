//
//  StoryController.swift
//  adventureSomething
//
//  Created by iD Student on 8/8/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import UIKit

class StoryController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HERE")
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
}

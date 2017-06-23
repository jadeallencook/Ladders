//
//  GameViewController.swift
//  ladders
//
//  Created by Jade Cook on 6/22/17.
//  Copyright © 2017 Jade Allen Cook. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            
            // load level one sks file
            let level = SKScene(fileNamed: "level1")
            
            // scale to fir
            level!.scaleMode = .aspectFill
            
            // add physics
            level!.physicsWorld.gravity = CGVector(dx: 0, dy: -9)
            
            // present scene
            view.presentScene(level)
            
            // for testing
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            
        }

    }
    
    override var shouldAutorotate: Bool {
        return false
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
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

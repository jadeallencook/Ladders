//
//  GameScene.swift
//  ladders
//
//  Created by Jade Cook on 6/22/17.
//  Copyright © 2017 Jade Allen Cook. All rights reserved.
//

import SpriteKit
import GameplayKit

// cache current level
var currentLevel = 0

class GameScene: SKScene {
    
    // cache game objects
    let player = SKSpriteNode()
    let levelLabel = SKLabelNode()
    
    func renderScene() {
        // get screen width
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width * 2
        let screenHeight = screenSize.height * 2
        
        // set level label
        self.levelLabel.text = "Level \(currentLevel + 1)"
        self.levelLabel.fontColor = .black
        self.levelLabel.fontSize = 100
        self.levelLabel.position.y += screenHeight * 0.35
        
        // stylize player
        self.player.size.width = 50
        self.player.size.height = 50
        self.player.color = .black
        self.player.position.y += 150
        self.player.position.x -= screenWidth / 4
        
        // apply physics to player
        self.player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        self.player.physicsBody?.allowsRotation = true
        
        // player animation
        let movePlayerToRightSide = SKAction.moveTo(x: ((screenWidth / 2) - (player.size.width / 2)), duration: 2)
        let movePlayerToLeftSide = SKAction.moveTo(x: -((screenWidth / 2) - (player.size.width / 2)), duration: 2)
        let movePlayerSideToSide = SKAction.sequence([movePlayerToRightSide, movePlayerToLeftSide])
        let playerAnimation = SKAction.repeatForever(movePlayerSideToSide)
        self.player.run(playerAnimation)
        
        // add everything to scene
        scene?.addChild(player)
        scene?.addChild(levelLabel)
    }
    
    // game update loop
    override func didMove(to view: SKView) {
        renderScene()
    }
    
    // event listeners
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // set player jump height
        let playerJump = SKAction.moveTo(y: player.position.y + 150, duration: 0.10)
            
        // jump player
        let connects = player.physicsBody!.allContactedBodies()
        if connects.count > 0 {
            self.player.run(playerJump)
        }
    }
    
    // loading next levels
    func nextLevel() {
        
        // cache levels
        let levels = [SKScene(fileNamed: "level1"), SKScene(fileNamed: "level2"), SKScene(fileNamed: "level3")]
        
        // go to next level
        currentLevel += 1
        
        // go to beginning if no more levels
        if currentLevel > levels.count - 1 {
            currentLevel = 0
        }
        
        // cache view
        let view = self.view
        
        let level = levels[currentLevel]
        
        // scale to fir
        level?.scaleMode = .aspectFill
        
        // add physics
        level?.physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        
        // present scene
        view?.presentScene(level)
    }
    
    // checks on every frame
    override func didBeginContact(contact: SKPhysicsContact) {
        
        // cache all contacts with player
        let contacts = player.physicsBody!.allContactedBodies()
        
        // check if collision is with ladder
        if contacts.count > 0 {
            for object in contacts  {
                if object.node?.name == "ladder" {
                    scene?.removeAllChildren()
                    renderScene()
                    nextLevel()
                }
            }
        }
    }
}

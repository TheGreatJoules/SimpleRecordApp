//
//  GameScene.swift
//  RCD
//
//  Created by juliancarachure on 1/15/19.
//  Copyright © 2019 juliancarachure. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let grassBar    = SKSpriteNode(imageNamed: "grass")
    var record      = SKSpriteNode(imageNamed: "record")
    let girl        = SKSpriteNode(imageNamed: "girl")
    let scoreLabel  = SKLabelNode(text: "0")
    var score       = 0
    var gravityY    : Double = -2.0
    var gravityX    : Double = 2.0
    
    let right = SKAction.moveBy(x: 75, y: 0, duration: 0.9)
    let left = SKAction.moveBy(x: -75, y: 0, duration: 0.9)
    let up = SKAction.moveBy(x: 0, y: 75, duration: 0.9)
    let down = SKAction.moveBy(x: 0, y: -75, duration: 0.9)

    override func didMove(to view: SKView) {
        layoutScene()
        setupPhysics()
        setupGestures()
    }
    
    func setupGestures(){
        let swipeRight = UISwipeGestureRecognizer(target: self,action: #selector(GameScene.swipeRight(sender:)))
        swipeRight.direction = .right
        view?.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,action: #selector(GameScene.swipeLeft(sender:)))
        swipeLeft.direction = .left
        view?.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self,action: #selector(GameScene.swipeUp(sender:)))
        swipeUp.direction = .up
        view?.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,action: #selector(GameScene.swipeDown(sender:)))
        swipeDown.direction = .down
        view?.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeRight(sender: UISwipeGestureRecognizer) {
        print("right")
        record.run(right)
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer) {
        print("left")
        record.run(left)
    }
    
    @objc func swipeUp(sender: UISwipeGestureRecognizer) {
        print("up")
        record.run(up)
    }
    
    @objc func swipeDown(sender: UISwipeGestureRecognizer) {
        print("down")
        record.run(down)
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0, dy: gravityY)
        self.physicsWorld.contactDelegate = self
    }
    
    func incrementGravity(){
        gravityY -= 1.0
        gravityX -= 1.0
        physicsWorld.gravity = CGVector(dx: gravityX, dy: gravityY)
    }
    
    func updateScoreLabel(){
        scoreLabel.text = "\(score)"
    }
    
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        grassBar.size = CGSize(width: (frame.width * UIScreen.main.scale), height: (frame.height * UIScreen.main.scale)/20 )
        grassBar.position = CGPoint(x: 0, y: frame.minY+grassBar.frame.height/2)
        grassBar.zPosition = ZPositions.grass
        grassBar.physicsBody = SKPhysicsBody(rectangleOf: grassBar.frame.size)
        grassBar.physicsBody?.categoryBitMask = PhysicsCategories.grassCategory
        grassBar.physicsBody?.isDynamic = false
        addChild(grassBar)
        
        scoreLabel.fontName = "Avenir-Light"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        
        spawnRecord()
        spawnGirl()
    }
    
    func spawnGirl(){
        girl.size = CGSize(width: 50, height: 50)
        girl.position = CGPoint(x: frame.maxX - frame.midX/4, y: frame.minY+grassBar.frame.height+30)
        girl.zPosition = ZPositions.girl
        girl.physicsBody = SKPhysicsBody(circleOfRadius: girl.size.width/2)
        girl.physicsBody?.categoryBitMask = PhysicsCategories.girlCategory
        girl.physicsBody?.contactTestBitMask = PhysicsCategories.recordCategory
        girl.physicsBody?.collisionBitMask = PhysicsCategories.none
        girl.physicsBody?.isDynamic = false
        addChild(girl)
    }
    
    func spawnRecord(){
        record      = SKSpriteNode(imageNamed: "record")
        record.size = CGSize(width: 45.0, height: 50.0)
        record.position = CGPoint(x: frame.midX, y:frame.maxY)
        record.zPosition = ZPositions.record
        record.physicsBody = SKPhysicsBody(circleOfRadius: record.size.width/2)
        record.physicsBody?.categoryBitMask = PhysicsCategories.recordCategory
        record.physicsBody?.contactTestBitMask = PhysicsCategories.grassCategory
        record.physicsBody?.collisionBitMask = PhysicsCategories.none

        addChild(record)
    }
    
    func gameOver() {
        print("GameOver")
        let gameoverScene = GameOverScene(size: view!.bounds.size)
        view!.presentScene(gameoverScene)
    }
    
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.recordCategory | PhysicsCategories.grassCategory {
            gameOver()
            
        }
        
        if contactMask == PhysicsCategories.recordCategory | PhysicsCategories.girlCategory {
            print("hits girl")
            score += 1
            updateScoreLabel()
            record.run(SKAction.fadeOut(withDuration: 0.05), completion: {
                self.record.removeFromParent()
                self.spawnRecord()
            })
            
        }
        //if girl and record match update score
    }
}

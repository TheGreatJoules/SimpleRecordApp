//
//  GameOverScene.swift
//  RCD
//
//  Created by juliancarachure on 1/16/19.
//  Copyright © 2019 juliancarachure. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLabels()
    }
    
    func addLabels(){
        let gameoverLabel = SKLabelNode(text: "Game Over")
        gameoverLabel.fontName = "Avenir-Bold"
        gameoverLabel.fontSize = 60.0
        gameoverLabel.fontColor = UIColor.white
        gameoverLabel.position = CGPoint(x: frame.midX, y: frame.midY+100)
        addChild(gameoverLabel)
        
        let tryagainLabel = SKLabelNode(text: "Try Again")
        tryagainLabel.fontName = "Avenir-Light"
        tryagainLabel.fontSize = 50
        tryagainLabel.fontColor = UIColor.white
        tryagainLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(tryagainLabel)
        animate(label: tryagainLabel)

    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([scaleUp,scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)

    }
    
    
}

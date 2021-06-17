//
//  MenuScene.swift
//  RCD
//
//  Created by juliancarachure on 1/16/19.
//  Copyright © 2019 juliancarachure. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "record")
        logo.size = CGSize(width: frame.width/1.8, height: frame.height/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY+frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontName = "ArialMT"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let recentScoreLabel = SKLabelNode(text: "By: Jesse & Julian Carachure")
        recentScoreLabel.fontName = "Avenir-Light"
        recentScoreLabel.fontSize = 20
        recentScoreLabel.fontColor = UIColor.white
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - recentScoreLabel.frame.size.height*3)
        addChild(recentScoreLabel)
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

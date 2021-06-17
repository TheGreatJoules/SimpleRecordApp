//
//  GameViewController.swift
//  RCD
//
//  Created by juliancarachure on 1/15/19.
//  Copyright © 2019 juliancarachure. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                view.ignoresSiblingOrder    = true
                // Debug
                view.showsFPS               = true
                view.showsNodeCount         = true
        }
    }

}

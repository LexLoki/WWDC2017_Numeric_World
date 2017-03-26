//
//  GameViewController.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/9/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var gv : GameView!
    var isVoice = true
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gv = GameView(frame: view.frame)
        self.gv = gv
        // Load the SKScene from 'GameScene.sks'
        scene = GameScene(size: gv.frame.size)
        // Set the scale mode to scale to fit the window
        //scene.scaleMode = SKSceneScaleMode.aspectFit
        
        // Present the scene
        gv.presentScene(scene)
        
        
        gv.ignoresSiblingOrder = true
        view.autoresizesSubviews = true
        gv.showsFPS = true
        gv.showsPhysics = true
        gv.showsNodeCount = true
        view.addSubview(gv)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gv.layoutSubviews()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
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

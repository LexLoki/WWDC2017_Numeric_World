//
//  Starter.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/13/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit
//import PlaygroundSupport

public func startScene(){
    let skV = SKView(frame: CGRect(x: 0, y: 0, width: 960, height: 540))
    let scene = GameScene(size: skV.frame.size)
    scene.scaleMode = .aspectFit
    skV.presentScene(scene)
    //PlaygroundPage.current.liveView = skV
}

//
//  Starter.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/13/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit
import PlaygroundSupport

public func startScene() -> GameScene{
    let skV = GameView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    let scene = GameScene(size: skV.frame.size)
    scene.messageSender = skV
    skV.presentScene(scene)
    scene.scaleMode = .aspectFill
    let page = PlaygroundPage.current
    page.liveView = skV
    //page.needsIndefiniteExecution = true
    scene.start()
    return scene
}

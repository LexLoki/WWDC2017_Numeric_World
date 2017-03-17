// 
//  Commands.swift
//
//  Copyright (c) 2017 Pietro Ribeiro Pepe. All Rights Reserved.
//

import SpriteKit
import PlaygroundSupport

/**
 Starts.
 */
public func movePlayer(leapSize: Int, leapQuant: Int) {
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("moveJumpDef"),
        "leapSize": .integer(leapSize),
        "leapQuant": .integer(leapQuant)
        ]))
}

public func runFlags(movements: [[Int]]){
    var movs = [PlaygroundValue]()
    for m in movements{
        movs.append(PlaygroundValue.array([.integer(m[0]),.integer(m[1])]))
    }
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("runFlags"),
        "movs" : .array(movs)
    ]))
}

public func putFlags(upToNumber num: Int){
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("putFlags"),
        "quant": .integer(num)
        ]))
}

public func moveStuff(_ leapSize: Int, _ leapQuant: Int){
    
}

public func start(){
}

private func sendProxy(_ pv : PlaygroundValue){
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(pv)
    }
}

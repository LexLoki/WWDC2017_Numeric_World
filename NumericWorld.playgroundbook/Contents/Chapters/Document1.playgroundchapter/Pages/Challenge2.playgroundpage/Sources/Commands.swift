// 
//  Commands.swift
//
//  Copyright (c) 2017 Pietro Ribeiro Pepe. All Rights Reserved.
//

import SpriteKit
import PlaygroundSupport

public func runJumps(jumps: [Int]){
    var js = [PlaygroundValue]()
    for j in jumps{
        js.append(PlaygroundValue.integer(j))
    }
    sendProxy(.dictionary([
        "method": .string("runJumps"),
        "jumps": .array(js)
    ]))
}

private func sendProxy(_ pv : PlaygroundValue){
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(pv)
    }
}

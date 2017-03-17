//
//  Speech.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/16/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class Speech : SKNode{
    
    let label : SKLabelNode
    private let spriteNode : SKSpriteNode
    
    init(text: String){
        label = SKLabelNode(text: text)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        let tex = SKTexture(imageNamed: "speech_bubble")
        let ts = tex.size()
        let ss = label.frame.size
        let s = max(ss.width/ts.width, ss.height/ts.height)
        spriteNode = SKSpriteNode(texture: tex, size: CGSize(width: s*ts.width, height: s*ts.height))
        super.init()
        spriteNode.addChild(label)
        addChild(spriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

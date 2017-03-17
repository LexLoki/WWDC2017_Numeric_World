//
//  Flag.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/15/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class Flag : SKNode{
    
    let label : SKLabelNode
    let number : Int
    
    private let spriteNode : SKSpriteNode
    private static let texture = SKTexture(imageNamed: "flag")
    
    static let defaultZPos : CGFloat = 0.5
    
    
    init(number: Int, refWidth: CGFloat){
        self.number = number
        let ts = Flag.texture.size()
        spriteNode = SKSpriteNode(texture: Flag.texture,size: CGSize(width: refWidth, height:refWidth/ts.width*ts.height))
        spriteNode.position = CGPoint(x: -0.32677165354331*spriteNode.size.width, y: spriteNode.size.height/2)
        label = SKLabelNode(text: "\(number)")
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.zPosition = Flag.defaultZPos
        spriteNode.addChild(label)
        label.position = CGPoint(x: 0.03543307086614*spriteNode.size.width, y: 0.30373831775701*spriteNode.size.height)
        //68 84
        super.init()
        zPosition = 1
        addChild(spriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

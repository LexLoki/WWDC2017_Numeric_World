//
//  ParallaxNode.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/13/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class ParallaxNode : SKNode{
    
    private let size : CGSize
    private let tWidth : CGFloat
    
    init(texture : SKTexture, size: CGSize){
        self.size = size
        let back = SKSpriteNode(texture: texture)
        let tSize = texture.size()
        back.size = CGSize(width: tSize.width*size.height/tSize.height, height: size.height)
        tWidth = back.size.width
        super.init()
        back.position.x = -size.width/2+back.size.width/2
        for i in 1...1{
            let nd = SKSpriteNode(texture: texture, size: back.size)
            nd.position.x = back.position.x+back.size.width*CGFloat(i)
            addChild(nd)
        }
        addChild(back)
    }
    
    func update(position : CGFloat){
        if position - size.width/2 > self.position.x+tWidth{
            self.position.x += tWidth
        }
        else if position < self.position.x+size.width/2{
            self.position.x -= tWidth
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

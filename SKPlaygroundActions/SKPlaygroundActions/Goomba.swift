//
//  Goomba.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/15/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class Goomba : SKNode{
    
    var wasHit = false
    
    private static let textures : [SKTexture] = [
        SKTexture(imageNamed: "frame_e-1"),
        SKTexture(imageNamed: "frame_e-2"),
        SKTexture(imageNamed: "frame_e-3"),
        SKTexture(imageNamed: "frame_e-4"),
        SKTexture(imageNamed: "frame_e-5"),
        SKTexture(imageNamed: "frame_e-6"),
        SKTexture(imageNamed: "frame_e-7"),
        SKTexture(imageNamed: "frame_e-8")
    ]
    
    private static let sound = SKAction.playSoundFileNamed("Boup.wav", waitForCompletion: true)
    
    private let spriteNode : SKSpriteNode
    
    init(refWidth: CGFloat){
        let tex = Goomba.textures.first!
        let ts = tex.size()
        spriteNode = SKSpriteNode(texture: Goomba.textures.first!, size: CGSize(width: refWidth, height: ts.height * refWidth/ts.width))
        super.init()
        spriteNode.position.y = spriteNode.size.height/2
        addChild(spriteNode)
        spriteNode.run(SKAction.repeatForever(SKAction.animate(with: Goomba.textures, timePerFrame: 0.08)))
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.size.width/2)//SKPhysicsBody(rectangleOf: spriteNode.size)
        spriteNode.physicsBody!.categoryBitMask = 1
        //spriteNode.physicsBody!.isDynamic = false
        spriteNode.physicsBody!.collisionBitMask = 0
        spriteNode.physicsBody!.affectedByGravity = false
        zPosition = 3
    }
    
    func hit(){
        print("come on")
        if !wasHit{
            wasHit = true
            run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3),Goomba.sound]), completion: {
                self.removeFromParent()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

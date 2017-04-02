//
//  Player.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/17/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class Player : SKSpriteNode{
    
    private(set) var asset: CharAsset!
    
    var isEnabledCharSwitch = true
    
    private let switchSound = SKAction.playSoundFileNamed("bleep sound.mp3", waitForCompletion: false)
    
    init(){
        asset = CharAsset.getAsset()
        let tex = asset.idle.first!
        super.init(texture: tex,color: UIColor.clear, size: tex.size())
        physicsBody = Player.preparePhysics(size: CGSize(width: size.width*0.7,height: size.height*0.7))
        reRunIdle()
        isUserInteractionEnabled = true
    }
    
    func reRunIdle(){
        if action(forKey: "sprite") != nil{
            removeAction(forKey: "sprite")
        }
        run(SKAction.repeatForever(SKAction.animate(with: asset.idle, timePerFrame: 0.3)), withKey: "sprite")
    }
    
    func prepareSize(refWidth: CGFloat, floor: CGFloat){
        let playerWidth : CGFloat = refWidth
        size = CGSize(width: playerWidth, height: size.height*playerWidth/size.width)
        physicsBody = Player.preparePhysics(size: CGSize(width: size.width*0.7,height: size.height*0.7))
        position.y = floor+size.height/2//80
    }
    
    private class func preparePhysics(size: CGSize)->SKPhysicsBody{
        let p = SKPhysicsBody(rectangleOf: size)
        p.contactTestBitMask = 1
        p.collisionBitMask = 0
        p.affectedByGravity = false
        return p
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isEnabledCharSwitch{
            asset = CharAsset.changeAsset()
            reRunIdle()
            run(switchSound)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

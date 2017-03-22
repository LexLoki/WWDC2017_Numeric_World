//
//  GameScene.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/9/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player : Player!
    
    let camNode = SKCameraNode()
    
    /// Distance between numbers
    var numberDist : CGFloat = 100
    
    /// Idle textures
    let standing : [SKTexture] = [SKTexture(imageNamed: "frame-1"),SKTexture(imageNamed: "frame-2")]
    
    /// Jump and fall textures
    let jumping : [SKTexture] = [SKTexture(imageNamed: "jump_up"),SKTexture(imageNamed: "jump_fall")]
    
    /// Running textures
    let running : [SKTexture] = [SKTexture(imageNamed: "frame_r-1"),SKTexture(imageNamed: "frame_r-2"),SKTexture(imageNamed: "frame_r-3"),SKTexture(imageNamed: "frame_r-4"),SKTexture(imageNamed: "frame_r-5"),SKTexture(imageNamed: "frame_r-6")]
    
    /// The height where the player feet should land
    var floor : CGFloat!
    
    /// Reference width for player
    var refWidth : CGFloat!
    
    var background : ParallaxNode!
    
    var numbers : [SKSpriteNode] = [SKSpriteNode]()
    
    var boxCeil : CGFloat!
    
    private var isRunning = false
    
    private var holdFlags : [Int]!
    private var flags = [Flag]()
    
    private var selectedFlag : Flag!
    
    override init(size: CGSize) {
        super.init(size: size)
        //camNode.position = CGPoint(x: size.width, y: 0)
        addChild(camNode)
        camera = camNode
        prepareBackground()
        print("init")
    }
    
    func resize(_ nSize: CGSize){
        print("HELLO")
        background.setSize(nSize)
        /*
        print(xScale,yScale)
        let s = nSize.height/size.height
        xScale = s
        yScale = s
        size.width = nSize.width
        size.height = nSize.height
        //let s = min(<#T##vector: double2##double2#>, <#T##scalar: Double##Double#>)*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        physicsWorld.contactDelegate = self
        print(size.width)
        floor = -0.28*size.height
        refWidth = 0.145*size.width
        boxCeil = floor + 0.75*refWidth
        numberDist = refWidth*1.15
        player = Player()
        player.position = CGPoint(x: 0, y: 0)
        player.zPosition = 5
        //prepareFlags(n: 10)
        addChild(player)
        start()
        
        //Page setup
        prepareFlags(n: 10)
        //prepareFlags(numbers: [4,1,3,2])
    }
    
    func start(){
        player.prepareSize(refWidth: refWidth, floor: floor)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let gb = contact.bodyA.node?.parent as? Goomba{
            gb.hit()
        }
        else if let gb = contact.bodyB.node?.parent as? Goomba{
            gb.hit()
        }
    }
    
    func prepareBackground(){
        let back = ParallaxNode(texture: SKTexture(imageNamed: "background"), size: size)
        back.zPosition = -1
        addChild(back)
        background = back
    }
    
    private func selectFlag(){
        
    }
    
    private func putFlag(_ px: CGFloat) -> SKAction{
        return SKAction.run {
            if self.selectedFlag != nil{
                self.selectedFlag.removeFromParent()
                self.addChild(self.selectedFlag)
                self.selectedFlag.position.x = px
                self.selectedFlag.zPosition = Flag.defaultZPos
                self.selectedFlag.position.y = self.floor
                self.selectedFlag = nil
            }
        }
    }
    
    private func pickFlag(_ flag: Flag) -> SKAction{
        return SKAction.run {
            self.selectedFlag = flag
            flag.removeFromParent()
            self.player.addChild(flag)
            flag.zPosition = -0.5
            flag.position.x = 0
            flag.position.y = 0
        }
    }
    
    private func getAction(_ pi: CGFloat, _ pf: CGFloat) -> SKAction{
        return SKAction.group([
            SKAction.moveTo(x: pf, duration: TimeInterval(abs(pf-pi)/numberDist)),
            SKAction.run({
                self.player.xScale = pf>pi ? 1 : -1
            })
        ])
    }
    
    func runFlags(movs : [[Int]]){
        isRunning = true
        let runningAction = SKAction.repeatForever(SKAction.animate(with: player.asset.running, timePerFrame: 0.2))
        player.run(runningAction, withKey: "run")
        let flagSound = SKAction.playSoundFileNamed("pick2.mp3", waitForCompletion: false)
        var actions = [SKAction]()
        var lastP = player.position.x
        for m in movs{
            let f1 = m[0]
            let f2 = m[1]
            let p1 = CGFloat(f1) * numberDist
            let p2 = CGFloat(f2) * numberDist
            let flag1 = flags[f1]
            let flag2 = flags[f2]
            actions.append(getAction(lastP,p1))
            actions.append(flagSound)
            actions.append(pickFlag(flag1))
            actions.append(getAction(p1,p2))
            actions.append(putFlag(p2))
            actions.append(flagSound)
            actions.append(pickFlag(flag2))
            actions.append(getAction(p2,p1))
            actions.append(putFlag(p1))
            actions.append(flagSound)
            flags[f2] = flag1
            flags[f1] = flag2
            lastP = p1
        }
        player.run(SKAction.sequence(actions)) {
            self.player.removeAction(forKey: "run")
        }
        
    }
    
    func prepareFlags( numbers : [Int]){
        var numbers = numbers
        if holdFlags != nil{
            numbers = holdFlags
        } else{
            holdFlags = numbers
        }
        for f in flags{
            f.removeFromParent()
        }
        flags = [Flag]()
        for i in 0..<numbers.count{
            let flag = Flag(number: numbers[i], refWidth: refWidth)
            flag.position = CGPoint(x: numberDist*CGFloat(i), y: floor)
            addChild(flag)
            if i>0{
                //let gb = Goomba(refWidth: refWidth*0.48)
                //gb.position = CGPoint(x: flag.position.x, y: floor)
                //addChild(gb)
            }
            flags.append(flag)
        }
    }
    
    func prepareFlags(n : Int){
        var numbers = [Int]()
        for i in 0...n{
            numbers.append(i)
        }
        prepareFlags(numbers : numbers)
    }
    
    func animateJump(){
        let animationAction = SKAction.animate(with: player.asset.jump, timePerFrame: 1)
        player.run(animationAction)
    }
    
    func moveJump(numWidth : Int = 2, numJumps : Int = 5){
        let d = CGFloat(numWidth)*numberDist/2
        var count = 0
        var actions = [SKAction]()
        let jumpDuration : TimeInterval = 1.4
        let animationAction = SKAction.animate(with: player.asset.jump, timePerFrame: jumpDuration/2)
        while count<numJumps{
            let moveUpAction = SKAction.moveBy(x: d, y: 130, duration: jumpDuration/2)
            let moveDownAction = SKAction.moveBy(x: d, y: -130, duration: jumpDuration/2)
            let jumpSound = SKAction.playSoundFileNamed("Jump.wav", waitForCompletion: false)
            
            let group = SKAction.group([animationAction,jumpSound, SKAction.sequence([moveUpAction,moveDownAction,SKAction.wait(forDuration: 0.2)])])
            actions.append(group)
            count += 1
        }
        let jumpSequence = SKAction.sequence(actions)
        
        player.run(jumpSequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first!.location(in: self).y > 0.4*size.height{
            runFlags(movs: [
                [4,3],
                [6,1]
                ])
        }
        //moveJump()
        //check if touched character
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if !isRunning{
            let t = touches.first!
            let dist = (t.location(in: self)-t.previousLocation(in: self)).x
            camNode.position.x = (camNode.position.x-dist).clamp(min: -size.width/2, max: numberDist*CGFloat(flags.count)+size.width/2)
        }
    }
    
    override func didFinishUpdate() {
        if self.isRunning{
            camNode.position.x = player.position.x
        }
        background.update(position: camNode.position.x)
    }
}

extension SKAction{
    class func moveTo(x: CGFloat, y: CGFloat, duration: TimeInterval) -> SKAction{
        return SKAction.move(to: CGPoint(x:x,y:y), duration: duration)
    }
}

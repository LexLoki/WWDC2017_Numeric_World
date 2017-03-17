//
//  GameScene.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/9/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit
import GameplayKit
import PlaygroundSupport

public class GameScene: SKScene {
    
    weak var messageSender : PlaygroundLiveViewMessageHandler!
    
    var player : SKSpriteNode!
    
    let camNode = SKCameraNode()
    
    /// Distance between numbers
    var numberDist : CGFloat = 100
    
    /// Idle textures
    let standing : [SKTexture] = [SKTexture(imageNamed: "frame-1"),SKTexture(imageNamed: "frame-2")]
    
    /// Jump and fall textures
    let jumping : [SKTexture] = [SKTexture(imageNamed: "jump_up"),SKTexture(imageNamed: "jump_fall")]
    
    /// The height where the player feet should land
    var floor : CGFloat!
    
    /// Reference width for player
    var refWidth : CGFloat!
    
    /// Running textures
    let running : [SKTexture] = [SKTexture(imageNamed: "frame_r-1"),SKTexture(imageNamed: "frame_r-2"),SKTexture(imageNamed: "frame_r-3"),SKTexture(imageNamed: "frame_r-4"),SKTexture(imageNamed: "frame_r-5"),SKTexture(imageNamed: "frame_r-6")]
    
    var background : ParallaxNode!
    
    private var isRunning : Bool = false
    
    private var flags = [Flag]()
    
    private var selectedFlag : Flag!
    
    public override init(size: CGSize) {
        super.init(size: size)
        addChild(camNode)
        camera = camNode
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        print(size.width)
        floor = -0.28*size.height
        refWidth = 0.145*size.width
        numberDist = refWidth*1.25
        prepareBackground()
        player = SKSpriteNode(color: UIColor.red, size: standing.first!.size())
        player.position = CGPoint(x: 0, y: 0)
        player.zPosition = 1
        //prepareFlags(n: 10)
        addChild(player)
        //animateJump()
    }
    
    func prepareBackground(){
        let back = ParallaxNode(texture: SKTexture(imageNamed: "background"), size: size)
        back.zPosition = -1
        addChild(back)
        background = back
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
            flag.zPosition = -0.1
            flag.position.x = 0
            flag.position.y = 0
        }
    }
    
    private func getAction(_ pi: CGFloat, _ pf: CGFloat) -> SKAction{
        return SKAction.group([
            SKAction.moveTo(x: pf, duration: TimeInterval(abs(pf-pi)/(numberDist*1.2))),
            SKAction.run({
                self.player.xScale = pf>pi ? 1 : -1
            })
            ])
    }
    
    func runFlags(movs : [[Int]]){
        isRunning = true
        let runningAction = SKAction.repeatForever(SKAction.animate(with: running, timePerFrame: 0.2))
        player.run(runningAction, withKey: "run")
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
            actions.append(pickFlag(flag1))
            actions.append(getAction(p1,p2))
            actions.append(putFlag(p2))
            actions.append(pickFlag(flag2))
            actions.append(getAction(p2,p1))
            actions.append(putFlag(p1))
            flags[f2] = flag1
            flags[f1] = flag2
            lastP = p1
        }
        player.run(SKAction.sequence(actions)) {
            self.player.removeAction(forKey: "run")
        }
    }
    
    public func start(){
        let playerWidth : CGFloat = refWidth//60
        player.size = CGSize(width: playerWidth, height: size.height*playerWidth/size.width)
        player.position.y = floor+player.size.height/2//80
        let standingAnimation = SKAction.animate(with: standing, timePerFrame: 0.3)
        let keepGoing = SKAction.repeatForever(standingAnimation)
        player.run(keepGoing)
    }
    
    public func prepareFlags(numbers : [Int]){
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
    
    public func prepareFlags(n : Int){
        var numbers = [Int]()
        for i in 0...n{
            numbers.append(i)
        }
        prepareFlags(numbers : numbers)
    }
    
    func animateJump(){
        let animationAction = SKAction.animate(with: jumping, timePerFrame: 1)
        player.run(animationAction)
    }
    
    func moveJumpDef(){
        moveJump()
    }
    
    func moveJump(numWidth : Int = 2, numJumps : Int = 5){
        isRunning = true
        let d = CGFloat(numWidth)*numberDist/2
        var count = 0
        var actions = [SKAction]()
        let jumpDuration : TimeInterval = 1.4
        let animationAction = SKAction.animate(with: jumping, timePerFrame: jumpDuration/2)
        while count<numJumps{
            let moveUpAction = SKAction.moveBy(x: d, y: 100, duration: jumpDuration/2)
            let moveDownAction = SKAction.moveBy(x: d, y: -100, duration: jumpDuration/2)
            //actions.append(moveUpAction)
            //actions.append(moveDownAction)
            let group = SKAction.group([animationAction, SKAction.sequence([moveUpAction,moveDownAction,SKAction.wait(forDuration: 0.2)])])
            actions.append(group)
            count += 1
        }
        let jumpSequence = SKAction.sequence(actions)
        //hidden code
        
        //-hidden code
        player.run(jumpSequence)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if !isRunning{
            let t = touches.first!
            let dist = (t.location(in: self)-t.previousLocation(in: self)).x
            camNode.position.x = (camNode.position.x-dist).clamp(min: -size.width/2, max: numberDist*CGFloat(flags.count)+size.width/2)
        }
    }
    
    public override func didFinishUpdate() {
        super.didFinishUpdate()
        if self.isRunning{
            camNode.position.x = player.position.x
        }
        background.update(position: camNode.position.x)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //camNode.position.x = player.position.x//camNode.position.x + 0.6*(player.position.x-camNode.position.x)
    }
}

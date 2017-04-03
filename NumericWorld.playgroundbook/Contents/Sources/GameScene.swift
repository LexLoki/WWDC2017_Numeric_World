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
    
    /// Funciona como delegate para poder enviar mensagens de volta para a LiveView
    weak var messageSender : GameView!
    
    var player : Player!
    
    let camNode = SKCameraNode()
    
    /// Distance between numbers
    var numberDist : CGFloat = 100
    
    /// The height where the player feet should land
    var floor : CGFloat!
    
    /// Reference width for player
    var refWidth : CGFloat!
    
    var background : ParallaxNode!
    
    private var isRunning : Bool = false
    
    private var hasJumps : Bool = false
    
    private var holdFlags : [Int]!
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
        player = Player()
        player.position = CGPoint(x: 0, y: 0)
        player.zPosition = 5
        //prepareFlags(n: 10)
        addChild(player)
        //animateJump()
        
        playMusic(path: "Audio/Little, happy tune.mp3")
    }
    
    func playMusic(path : String){
        run(SKAction.repeatForever(SKAction.playSoundFileNamed(path, waitForCompletion: true)), withKey: "audio")
    }
    
    func setVoiceOver(_ isOn: Bool){
        if !isOn{
            removeAction(forKey: "voice")
        }
        FlagLabel.voiceOverEnabled = isOn
    }
    
    func prepareBackground(){
        let back = ParallaxNode(texture: SKTexture(imageNamed: "background"), size: size)
        back.zPosition = -1
        addChild(back)
        background = back
    }
    
    private func putFlag(_ px: CGFloat) -> SKAction{
        let mov = SKAction.run {
            if self.selectedFlag != nil{
                self.selectedFlag.run(SKAction.moveTo(y: self.floor, duration: 0.3))
                self.selectedFlag = nil
            }
        }
        let wait = SKAction.wait(forDuration: 0.34)
        let put = SKAction.run {
            if self.selectedFlag != nil{
                self.selectedFlag.removeFromParent()
                self.addChild(self.selectedFlag)
                self.selectedFlag.position.x = px
                self.selectedFlag.zPosition = Flag.defaultZPos
                self.selectedFlag.position.y = self.player.position.y//self.floor
            }
        }
        return SKAction.sequence([put, SKAction.group([mov,wait])])
    }
    
    private func pickFlag(_ flag: Flag) -> SKAction{
        let mov = SKAction.run {
            flag.run(SKAction.moveTo(y: self.player.position.y, duration: 0.3))
        }
        let wait = SKAction.wait(forDuration: 0.34)
        let pick = SKAction.run {
            self.selectedFlag = flag
            flag.removeFromParent()
            self.player.addChild(flag)
            flag.zPosition = -0.5
            flag.position.x = 0
            flag.position.y = 0
        }
        return SKAction.sequence([SKAction.group([wait,mov]),pick])
    }
    /*
    private func pickFlag(_ flag: Flag) -> SKAction{
        return SKAction.run {
            self.selectedFlag = flag
            flag.removeFromParent()
            self.player.addChild(flag)
            flag.zPosition = -0.1
            flag.position.x = 0
            flag.position.y = 0
        }
    }*/
    
    private func getAction(_ pi: CGFloat, _ pf: CGFloat) -> SKAction{
        return SKAction.group([
            SKAction.moveTo(x: pf, duration: TimeInterval(abs(pf-pi)/(numberDist*1.2))),
            SKAction.run({
                self.player.xScale = pf>pi ? 1 : -1
            })
            ])
    }
    
    func cancel(){
        if !isRunning{
            return
        }
        isRunning = false
        player.removeAllActions()
        player.reRunIdle()
        if holdFlags != nil{
            prepareFlags(numbers: holdFlags)
        }
        if hasJumps{
            player.position.x = 0
            player.position.y = 0
            hasJumps = false
        }
    }
    
    func runFlags(movs : [[Int]]){
        isRunning = true
        let runningAction = SKAction.repeatForever(SKAction.animate(with: player.asset.running, timePerFrame: 0.2))
        player.run(runningAction, withKey: "run")
        let flagSound = SKAction.playSoundFileNamed("Audio/pick2.mp3", waitForCompletion: false)
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
            actions.append(putFlag(p2)); actions.append(flagSound)
            actions.append(pickFlag(flag2))
            actions.append(getAction(p2,p1))
            actions.append(putFlag(p1)); actions.append(flagSound)
            flags[f2] = flag1
            flags[f1] = flag2
            lastP = p1
        }
        player.run(SKAction.sequence(actions)) {
            self.isRunning = false
            self.player.removeAction(forKey: "run")
            let v = self.verifyFlags()
            if v{
                self.playSuccessSound()
            }
            self.messageSender?.sendMessage("finished",v)
        }
    }
    
    func playSuccessSound(){
        run(SKAction.playSoundFileNamed("Audio/success.mp3", waitForCompletion: false))
    }
    
    func verifyFlags() -> Bool{
        for i in 0..<flags.count{
            if flags[i].number != i+1{
                return false
            }
        }
        return true
    }
    
    public func start(){
        player.prepareSize(refWidth: refWidth, floor: floor)
    }
    
    public func prepareFlags(numbers : [Int]){
        holdFlags = numbers
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
    
    public func prepareFlags(n : Int, putZero: Bool = false){
        var numbers = [Int]()
        if putZero{
            numbers.append(0)
        }
        for i in 1...n{
            numbers.append(i)
        }
        prepareFlags(numbers : numbers)
    }
    
    func animateJump(){
        let animationAction = SKAction.animate(with: player.asset.jump, timePerFrame: 1)
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
        let animationAction = SKAction.animate(with: player.asset.jump, timePerFrame: jumpDuration/2)
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
    
    func runJumps(jumps : [Int]){
        isRunning = true
        hasJumps = true
        var actions = [SKAction]()
        let jumpDuration : TimeInterval = 1.4
        let anim = SKAction.animate(with: player.asset.jump, timePerFrame: jumpDuration/2)
        let sound = SKAction.playSoundFileNamed("Audio/Boup.wav", waitForCompletion: false)
        var pos = 0
        for jump in jumps{
            let d = numberDist*CGFloat(jump)/2
            let moveUp = SKAction.moveBy(x: d, y: 100, duration: jumpDuration/2)
            let moveDown = SKAction.moveBy(x: d, y: -100, duration: jumpDuration/2)
            actions.append(SKAction.run({
                self.player.xScale = jump<0 ? -1 : 1
            }))
            let group = SKAction.group([anim, sound, SKAction.sequence([moveUp,moveDown,SKAction.wait(forDuration: 0.2)])])
            pos += jump
            actions.append(group)
            if pos<0 || pos>8{
                break
            }
        }
        let status = pos<0 ? -1 : pos>8 ? 1 : pos==0 ? 0 : 2
        actions.append(SKAction.run({
            self.messageSender?.sendMessageS("assert",status)
            if status == 0{
                self.playSuccessSound()
            }
        }))
        let runningAction = SKAction.repeatForever(SKAction.animate(with: player.asset.running, timePerFrame: 0.2))
        actions.append(SKAction.run({
            self.player.run(runningAction, withKey: "run")
        }))
        let mov = Double(abs(pos))
        actions.append( SKAction.run({  //scale direction
            self.player.xScale = pos>0 ? -1 : 1
        }))
        actions.append( SKAction.moveTo(x: 0, duration: TimeInterval(mov/1.2)) ) //backing to zero
        player.run(SKAction.sequence(actions)){
            self.isRunning = false
            self.hasJumps = false
            self.player.removeAction(forKey: "run")
            self.messageSender?.sendMessage("finished",false)
        }
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

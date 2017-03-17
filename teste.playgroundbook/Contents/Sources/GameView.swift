import SpriteKit
import PlaygroundSupport

class GameView : SKView{
    
    fileprivate var _scene : GameScene{
        return scene as! GameScene
    }
    
}

extension GameView: PlaygroundLiveViewMessageHandler {
    
    public func liveViewMessageConnectionOpened() {
    }
    
    public func liveViewMessageConnectionClosed() {
    }
    
    public func receive(_ message: PlaygroundValue) {
        guard let method = message.stringFromDict(withKey: "method") else { return }
        switch (method) {
        case "moveJumpDef":
            let leapSize = message.integerFromDict(withKey: "leapSize")!
            let leapQuant = message.integerFromDict(withKey: "leapQuant")!
            _scene.moveJump(numWidth: leapSize, numJumps: leapQuant)
            break
        case "putFlags":
            let q = message.integerFromDict(withKey: "quant")!
            _scene.prepareFlags(n: q)
            break
        case "runFlags":
            let arr = message.arrayFromDict(withKey: "movs")!
            var movs = [[Int]]()
            for v in arr{
                let pos = v.toArray()!
                movs.append([pos[0].toInt()!,pos[1].toInt()!])
            }
            _scene.runFlags(movs: movs)
            break
        default:
            break
        }
    }
}

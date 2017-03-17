import SpriteKit

class GameView : SKView{
    
    private var _scene : GameScene{
        return scene as! GameScene
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _scene.resize(frame.size)
    }
    
}

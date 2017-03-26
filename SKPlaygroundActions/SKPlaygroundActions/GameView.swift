import SpriteKit

class GameView : SKView{
    
    private var vb : UIButton!
    
    private var _scene : GameScene{
        return scene as! GameScene
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        vb = UIButton()
        vb.setImage(UIImage(named: "voiceover"), for: .normal)
        vb.setImage(UIImage(named: "voiceover_off"), for: .selected)
        vb.imageView?.contentMode = .scaleAspectFit
        vb.addTarget(self, action: #selector(GameView.vbTouch(b:)), for: .touchUpInside)
        addSubview(vb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func vbTouch(b: UIButton){
        _scene.setVoiceOver(b.isSelected)
        b.isSelected = !b.isSelected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _scene.resize(frame.size)
        vb.frame = CGRect(x:0.01*frame.width,y: 0.01*frame.height,width: 0.17*frame.width,height: 0.17*frame.height)
    }
    
}

//
//  FlagLabel.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/24/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class FlagLabel : SKLabelNode{
    
    public static var voiceOverEnabled = true
    
    init(text: String?) {
        super.init()
        self.text = text
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if FlagLabel.voiceOverEnabled{
            print("hello")
            run(SKAction.playSoundFileNamed("\(self.text!).mp3", waitForCompletion: false))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

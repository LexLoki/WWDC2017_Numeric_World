//
//  Assets.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/17/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit

class CharAsset{
    
    let idle: [SKTexture]
    let running: [SKTexture]
    let jump: [SKTexture]
    
    ///Gets the asset of the current set character
    class func getAsset() -> CharAsset{
        return CharAsset(id: ids[currentAsset])
    }
    
    ///Changes current character and return its asset
    class func changeAsset() -> CharAsset{
        currentAsset = (currentAsset+1)%ids.count
        return getAsset()
    }
    
    ///Identifier of current character being used
    private static var currentAsset: Int = 0
    ///Prefixes of each character
    private static let ids : [String] = ["b","g","r"]
    
    private init(id: String){
        idle = CharAsset.loadTextures(id,"i",2)
        running = CharAsset.loadTextures(id,"r",2)
        jump = CharAsset.loadTextures(id,"j",6)
    }
    
    private class func loadTextures(_ id: String, _ type: String, _ count: Int) -> [SKTexture]{
        var texts = [SKTexture]()
        for i in 1...count{
            texts.append(SKTexture(imageNamed: "\(id)_\(type)-\(i)"))
        }
        return texts
    }
}

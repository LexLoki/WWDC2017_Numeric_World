//
//  GameView.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/17/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import SpriteKit
import PlaygroundSupport

class GameView : SKView{
    
    fileprivate var _scene : GameScene{
        return scene as! GameScene
    }
    
}

//Recebimento de mensagens enviadas a partir de Contents.swift
extension GameView: PlaygroundLiveViewMessageHandler {
    
    public func liveViewMessageConnectionOpened() {
    }
    
    ///Chamada quando a contents  para de executar (quando por exemplo o usuario pressiona Stop)
    public func liveViewMessageConnectionClosed() {
        _scene.cancel()
    }
    
    ///Função chamada a partir da GameScene para enviar alguma mensagem para Contents.swift
    public func sendMessage(_ msg: String){
        let pv : PlaygroundValue = .string(msg)
        send(pv)
    }
    
    ///Recebe mensagens
    public func receive(_ message: PlaygroundValue) {
        guard let method = message.stringFromDict(withKey: "method") else { return } //Como a sintaxe para transformar de PlaygroundValue para o valor necessário é meio feia, algumas funções para simplificar foram definidas em Contensts/Sources/PlaygroundUtils.swift. stringFromDict, por exemplo, é pra retirar o valor de algum campo string, dada sua chave no dicionario (quando sabe-se é claro que o PV enviado é um dicionário)
        //Obtido o nome do método, fazemos um switch para trabalhar cada caso
        //(neste projeto está sendo usado mesmo o runFlags. os demais são exemplos)
        switch (method) {
        case "moveJumpDef":
            let leapSize = message.integerFromDict(withKey: "leapSize")!
            let leapQuant = message.integerFromDict(withKey: "leapQuant")!
            //Extraidos os valores leapSize e leapQuant, chamamos a função desejada na GameScene
            _scene.moveJump(numWidth: leapSize, numJumps: leapQuant)
            break
        case "putFlags":
            let q = message.integerFromDict(withKey: "quant")!
            _scene.prepareFlags(n: q)
            break
        case "runFlags":
            let arr = message.arrayFromDict(withKey: "movs")! //Retira-se vetor de PlaygroundValue
            var movs = [[Int]]()
            for v in arr{ //Percorre-se o vetor de PV
                let pos = v.toArray()! //Cada PV é também um vetor de PV ([Int])
                movs.append([pos[0].toInt()!,pos[1].toInt()!]) //Extrai-se os inteiros de cada PV
            }
            _scene.runFlags(movs: movs)
            break
        default:
            break
        }
    }
}

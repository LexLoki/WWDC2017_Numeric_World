// 
//  Commands.swift
//
//  Copyright (c) 2017 Pietro Ribeiro Pepe. All Rights Reserved.
//

import SpriteKit
import PlaygroundSupport

///Todos os dados enviados devem ser convertidos para PlaygroundValue
///para converter valores para PlaygroundValue:
/// string: PlaygroundValue.string(valor)
/// Int: PlaygroundValue.integer(valor)
/// Bool: PlaygroundValue.boolean(valor)
/// array: PlaygroundValue.array([valores aqui]) Obs: cada valor dentro TAMBÉM deve ser convertido para PlaygroundValue (em runFlags isso é feito)
///Entre outros... so olhar na documentação (date, data, double)

///Chamarei PlaygroundValue eventualmente de PV

/// Normalmente ao me comunicar com a GameView, estou querendo chamar uma determinada função, então irei sempre enviar um dicionário onde vou ter um campo com a key "method" informando o nome da função a ser executada, e outros campos com os demais valores necessários. Veja a função movePlayer abaixo (que não está sendo usada mas serve como exemplo)

///Ela precisa passar o tamanho do pulo e quantos pulos o jogador vai fazer, para que a GameScene possa efetuar a operação
public func movePlayer(leapSize: Int, leapQuant: Int) {
    /// Criamos um PlaygroundValue a partir de um dicionario e colocamos os campos
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("moveJumpDef"), ///convertendo a string "moveJumpDef" para PV
        "leapSize": .integer(leapSize), ///convertendo o inteiro leapSize para PV
        "leapQuant": .integer(leapQuant) ///convertendo o inteiro leapQuant para PV
        ]))
    ///Observe que no final tudo deve ser PV
}

///Essa funcao passa para a GameView os movimentos que o jogador deve fazer. Passa coleções de duplas de valores. Exemplo: 3 e 2, 4 e 5, 1 e 3 : faz o jogador trocas as bandeiras na posicao 3 com a na posicao 2, a posicao 4 com a na posicao 5, etc. cada dupla é um vetor de 2 valores, como temos varias duplas, temos um vetor de vetores (que precisa ser todo convertido para PV).
public func runFlags(movements: [[Int]]){
    var movs = [PlaygroundValue]() //o vetor precisa ser de PlaygroundValue
    for m in movements{ //Entao percorremos o [[Int]]
        movs.append(PlaygroundValue.array([.integer(m[0]),.integer(m[1])])) //Convertemos cada vetor [Int] em um PlaygroundValue, onde cada inteiro dentro ([0] e [1]) é convertido também para PlaygroundValue, e adicionamos ao nosso vetor de PlaygroundValue (movs)
    }
    //Enviamos um dicionario para indicar o método (runFlags) e com os movimentos convertidos de 'array de PlaygroundValue' para 'PlaygroundValue'
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("runFlags"),
        "movs" : .array(movs)
    ]))
}

public func putFlags(upToNumber num: Int){
    sendProxy(PlaygroundValue.dictionary([
        "method": .string("putFlags"),
        "quant": .integer(num)
        ]))
}

public func moveStuff(_ leapSize: Int, _ leapQuant: Int){
}

public func start(){
}

private func sendProxy(_ pv : PlaygroundValue){
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(pv)
    }
}

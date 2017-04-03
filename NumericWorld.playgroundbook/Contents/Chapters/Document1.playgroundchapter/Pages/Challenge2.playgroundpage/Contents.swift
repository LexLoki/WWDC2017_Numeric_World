//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2016 Pietro Ribeiro Pepe. All Rights Reserved.
//

//#-end-hidden-code
/*:
When Leo is not working he likes to play around **jumping over** the numbers instead of **walking by** them. He calls it a jump game, and it has some rules:
 - Leo always starts on number zero.
 - When Leo jumps to the right, he always jump over one number. So if he jumps once he will land on 2. If he jumps twice he will land on 4.
 - When Leo jumps to the left, he always jump over two numbers. For example: if he is at number 4 and jump to the left, he will land at 1.
 - Leo needs to get out of zero by jumping around and then get back to it.
 - If Leo goes past to zero (to the left), or past 8 (to the right) he loses the game and needs start again.
 - Leo needs to jump at least once.

 **Goal:** help Leo to jump some numbers and get back to zero!
 
 Complete the ``jumpGame()`` [function](glossary://function) by giving Leo [commands](glossary://command) to jump, as much as you want:
 - ``jumpRight()``: jumps 2 numbers to his right
 - ``jumpLeft()``: jumps 3 numbers to his left
*/
//#-hidden-code
import PlaygroundSupport

var jumps = [Int]()

func jumpRight(){
    jumps.append(2)
}
func jumpLeft(){
    jumps.append(-3)
}

//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, jumpLeft())
//#-code-completion(identifier, show, jumpRight())
func jumpGame(){
    //#-editable-code Tap to enter code
    //#-end-editable-code
}
//#-hidden-code
let page = PlaygroundPage.current
let listener : Listener
jumpGame()
if jumps.count == 0{
    page.assessmentStatus = .fail(hints: ["Leo needs to jump at least once! Enter your commands in `jumpGame`"], solution: nil)
}
else{
    page.needsIndefiniteExecution = true //Necessario para deixar a opção "Stop" no lugar de "Run Code"
    listener = Listener(page: page)
    runJumps(jumps: jumps)
}
//#-end-hidden-code

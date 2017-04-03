//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2016 Pietro Ribeiro Pepe. All Rights Reserved.
//

// O código aqui roda sempre que o usuário entra "Run Code"

//#-end-hidden-code
/*:
 Hello adventurer! This boy you see on your right is Leo, and he needs your help on his duties in the **numeric world**.
 
 In the **numeric world**, is important for people to walk through numbers in ascending order. Sadly, sometimes heavy storms mess them around, putting them in wrong order. Could you help Leo fix this?
 * callout(Tip):
 Want to change your character? Tap on Leo to chose a new look.
 
 **Goal:** Reorder the flags by completing the function.
 
 As you can see (by dragging your finger on the screen) the numbers on the flags are not in ascending order as they should be. Fortunately, you can help Leo switch the flags telling the positions you are switching them, using the [command](glossary://command) ``switchFlags(fromPosition: Int, toPosition: Int)``.
 You need to complete the [function](glossary://function) below, ``reorderFlags``, using this [command](glossary://command), to help Leo. Don't worry about doing it wrong, you can change the function as long as you want to and [call](glossary://call) it multiple times.
 - Note:
 The position Leo is initially standing is position 1, the first one in front of him is position 2, and so goes on...
 
 * callout(Tip):
 If you tap right on a number, Leo says it out loud for you. You can deactivate this by pressing the mic button
 
*/
//#-hidden-code
import PlaygroundSupport

let nFlags : Int = 4

var movements = [[Int]]()
func switchFlags(fromPosition flag1: Int, toPosition flag2: Int){
    assert(flag1>0 && flag1<=nFlags && flag2>0 && flag2<=nFlags, "The positions should be values between (including) 1 and 4")
    movements.append([flag1-1,flag2-1])
}

//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, switchFlags(fromPosition:toPosition:))
func reorderFlags(){
    //#-editable-code Tap to enter code
    //#-end-editable-code
}
//#-hidden-code
let page = PlaygroundPage.current
page.needsIndefiniteExecution = true //Necessario para deixar a opção "Stop" no lugar de "Run Code"
let listener = Listener(page: page) //Inicializa a classe para receber mensagens da LiveView (ver em Sources/Listener) (para nesse caso, por exemplo, saber quando tirar o "Stop" e colocar de volta o "Run Code"
reorderFlags() //Chama a função completada pelo jogador para preencher movements
runFlags(movements: movements) //Envia os movimentos para serem atualizados na LiveView (ver função runFlags em Sources/Commands.swift)
//#-end-hidden-code

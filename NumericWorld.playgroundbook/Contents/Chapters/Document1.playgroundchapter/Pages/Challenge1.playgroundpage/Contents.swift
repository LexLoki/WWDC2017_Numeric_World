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
 
 In the **numeric world**, is important for people to walk through numbers in ascending order. Sadly, sometimes heavy storms mess them around, giving us a wrong order. Could you help Leo fix them?
 * callout(Tip):
 Want to change your character? Tap on Leo to chose a new look.
 
 **Challenge:** Reorder the flags by completing the function.
 
 As you can see (by dragging your finger on the screen) the numbers on the flags are not in ascending order as they should be. You can switch the flags by their positions using the command `switchFlags(fromPosition: Int, toPosition: Int)`. Below there is a function `reorderFlags` you should complete, using this command, to help Leo. Don't worry about doing it wrong, you can change the function as long as you want to and try again.
*/
//#-hidden-code
import PlaygroundSupport

var movements = [[Int]]()
func switchFlags(fromPosition flag1: Int, toPosition flag2: Int){
    assert(flag1>0 && flag1<5 && flag2>0 && flag2<5, "The positions should be values between 1 and 4")
    movements.append([flag1-1,flag2-1])
}

//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, switchFlags(fromPosition:toPosition:))
func reorderFlags(){
    //#-editable-code Tap to enter code
    switchFlags(fromPosition: 2, toPosition: 3)
    /*Right Answer:
     switchFlags(fromPosition: 4, toPosition: 0)
     switchFlags(fromPosition: 2, toPosition: 3)
     switchFlags(fromPosition: 4, toPosition: 3)
     switchFlags(fromPosition: 4, toPosition: 5)
     switchFlags(fromPosition: 6, toPosition: 5)
    */
    //#-end-editable-code
}
//#-hidden-code
let page = PlaygroundPage.current
page.needsIndefiniteExecution = true //Necessario para deixar a opção "Stop" no lugar de "Run Code"
let listener = Listener(page: page) //Inicializa a classe para receber mensagens da LiveView (ver em Sources/Listener) (para nesse caso, por exemplo, saber quando tirar o "Stop" e colocar de volta o "Run Code"
reorderFlags() //Chama a função completada pelo jogador para preencher movements
runFlags(movements: movements) //Envia os movimentos para serem atualizados na LiveView (ver função runFlags em Sources/Commands.swift)
//#-end-hidden-code

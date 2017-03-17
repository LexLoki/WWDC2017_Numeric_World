//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2016 Apple Inc. All Rights Reserved.
//
//#-end-hidden-code
/*:
 Hello adventurer! This boy you see on your right is Leo, and he needs your help on his duties in the **numeric world**.
 
 In the **numeric world**, is important for people to walk through numbers in ascending order. Sadly, sometimes heavy storms mess them around, giving us a wrong order. Could you help Leo fix them?
 
 **Challenge:** Reorder the flags by completing the function.
 
 As you can see (by dragging your finger) the numbers on the flags are not in ascending order as they should be. You can switch the flags by their positions using the command `switchFlags(fromPosition: Int, toPosition: Int)`. Below there is a function `reorderFlags` you should complete, using this command, to help Leo. Don't worry about doing it wrong, you can change the function as long as you want to and try again.
*/
//#-hidden-code
import PlaygroundSupport
var movements = [[Int]]()
func switchFlags(fromPosition flag1: Int, toPosition flag2: Int){
    movements.append([flag1,flag2])
}
//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, switchFlags(flag1:flag2:))
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
//let page = PlaygroundPage.current
//page.needsIndefiniteExecution = true
reorderFlags()
runFlags(movements: movements)
//#-end-hidden-code
//putFlags(upToNumber: /*#-editable-code */12/*#-end-editable-code*/)
//movePlayer(leapSize: /*#-editable-code */2/*#-end-editable-code*/, leapQuant: /*#-editable-code */2/*#-end-editable-code*/)

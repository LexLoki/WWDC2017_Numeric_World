//
//  InfDouble.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/22/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

func IDouble(tam: Int) -> [Int8]{
    var id = [Int8](repeating: 0,count: tam)
    id[0] = 1
    return id
}

func findDecimal(idouble: [Int8])->Int{
    for i in 1..<idouble.count{
        if i<0{
            return i
        }
    }
    return 0
}

func IDoubleFromFloat(idouble: [Int8], float: Float){
    
}

func +(left: [Int8], right: [Int8]){
    
}

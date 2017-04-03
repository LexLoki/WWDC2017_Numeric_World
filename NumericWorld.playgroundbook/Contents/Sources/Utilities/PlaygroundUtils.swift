//
//  PlaygroundUtils.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/17/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import PlaygroundSupport

extension PlaygroundValue {
    
    ///Extrai string de um dicionario pv
    public func stringFromDict(withKey key: String) -> String? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .string(let str) = value {
            return str
        }
        return nil
    }
    
    ///Extrai inteiro de um dicionario pv
    public func integerFromDict(withKey key: String) -> Int? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .integer(let num) = value {
            return num
        }
        return nil
    }
    
    ///Extrai array pv de um dicionario pv
    public func arrayFromDict(withKey key: String) -> [PlaygroundValue]? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .array(let array) = value {
            return array
        }
        return nil
    }
    
    ///Extrai array pv de um dicionario pv
    public func booleanFromDict(withKey key: String) -> Bool? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .boolean(let bol) = value {
            return bol
        }
        return nil
    }
    
    ///Extrai inteiro de pv
    public func toInt() -> Int?{
        if case .integer(let num) = self{
            return num
        }
        return nil
    }
    
    
    ///Extrai array pv
    public func toArray() -> [PlaygroundValue]?{
        if case .array(let array) = self{
            return array
        }
        return nil
    }
    
    ///Extrai string de pv
    public func toString() -> String?{
        if case .string(let string) = self{
            return string
        }
        return nil
    }
}

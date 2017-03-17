import Foundation
import PlaygroundSupport

extension PlaygroundValue {
    func stringFromDict(withKey key: String) -> String? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .string(let str) = value {
            return str
        }
        return nil
    }
    
    func integerFromDict(withKey key: String) -> Int? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .integer(let num) = value {
            return num
        }
        return nil
    }
    
    func arrayFromDict(withKey key: String) -> [PlaygroundValue]? {
        if case .dictionary(let dict) = self,
            let value = dict[key],
            case .array(let array) = value {
            return array
        }
        return nil
    }
    
    func toInt() -> Int?{
        if case .integer(let num) = self{
            return num
        }
        return nil
    }
    
    func toArray() -> [PlaygroundValue]?{
        if case .array(let array) = self{
            return array
        }
        return nil
    }
}

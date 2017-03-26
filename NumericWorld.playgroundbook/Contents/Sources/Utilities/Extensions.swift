//
//  Extensions.swift
//  SKPlaygroundActions
//
//  Created by Pietro Ribeiro Pepe on 3/15/17.
//  Copyright © 2017 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

func -(left: CGPoint, right: CGPoint) -> CGPoint{
    return CGPoint(x: left.x-right.x, y: left.y-right.y)
}

extension CGFloat{
    func clamp(min: CGFloat, max: CGFloat) -> CGFloat{
        return self<min ? min : self>max ? max : self
    }
}

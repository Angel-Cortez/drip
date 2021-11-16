//
//  CGFloat+Random.swift
//  HelloWorld
//
//  Created by Angel Cortez on 11/15/21.
//

import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

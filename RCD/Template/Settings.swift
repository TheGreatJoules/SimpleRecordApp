//
//  Settings.swift
//  RCD
//
//  Created by juliancarachure on 1/15/19.
//  Copyright © 2019 juliancarachure. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none:            UInt32  = 0
    static let recordCategory:  UInt32  = 0x1 // 1
    static let grassCategory:   UInt32  = 0x1 << 1
    static let girlCategory:    UInt32  = 0x1 << 2
}

enum ZPositions {
    static let label:   CGFloat = 0
    static let record:  CGFloat = 1
    static let grass:   CGFloat = 2
    static let girl:    CGFloat = 3
}

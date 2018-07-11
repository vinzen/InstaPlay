//
//  Color+rgb.swift
//  InstaPlay
//
//  Created by Vincent Douant on 11/07/2018.
//  Copyright © 2018 Vincent Douant. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        let r = CGFloat(rgb >> 16) / 255
        let g = CGFloat((rgb & 0x00ff00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

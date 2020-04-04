//
//  UIColor_Extension.swift
//  PYATest
//
//  Created by Julio Collado on 4/3/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

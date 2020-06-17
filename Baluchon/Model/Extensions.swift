//
//  Extensions.swift
//  Baluchon
//
//  Created by anthonymfscott on 15/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

extension Float {
    var roundedToFirstDecimal: Float {
        return (self * 10).rounded() / 10
    }

    var roundedToSecondDecimal: Float {
        return (self * 100).rounded() / 100
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

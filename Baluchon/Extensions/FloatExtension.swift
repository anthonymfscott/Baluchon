//
//  Extensions.swift
//  Baluchon
//
//  Created by anthonymfscott on 15/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

extension Float {
    var roundedToSecondDecimal: Float {
        return (self * 100).rounded() / 100
    }

    var convertedToInt: Int {
        return Int(self)
    }
}

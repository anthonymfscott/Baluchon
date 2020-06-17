//
//  BannerView.swift
//  Baluchon
//
//  Created by anthonymfscott on 17/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class BannerView: UIView {
    func setDesign() {
        self.layer.cornerRadius = 50
        self.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        self.layer.shadowRadius = 0.7
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

//
//  BannerView.swift
//  Baluchon
//
//  Created by anthonymfscott on 17/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class BannerView: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
    }

    private func setDesign() {
        layer.cornerRadius = 50
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 0.7
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

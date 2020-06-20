//
//  BaluchonView.swift
//  Baluchon
//
//  Created by anthonymfscott on 18/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class BaluchonView: UIView {
    @IBOutlet var baluchonButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var baluchonStick: UIImageView!

    var isLoading = false {
        didSet {
            activityIndicator.isHidden = !isLoading
            baluchonButton.isEnabled = !isLoading
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
    }

    private func setDesign() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 0.7
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
}

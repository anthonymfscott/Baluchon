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

    var timer: Timer?

    var shouldPulsate = false {
        didSet {
            shouldPulsate ? startAnimation() : stopAnimation()
        }
    }

    var isLoading = false {
        didSet {
            activityIndicator.isHidden = !isLoading
            baluchonButton.isEnabled = !isLoading
        }
    }

    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { timer in
            self.pulsate()
        })
    }

    private func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }

    private func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 1.0
        pulse.toValue = 0.95
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        baluchonButton.layer.add(pulse, forKey: nil)
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

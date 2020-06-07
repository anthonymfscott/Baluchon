//
//  ViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 05/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var city1TextStackView: UIStackView!
    @IBOutlet var city1StackView: UIStackView!
    @IBOutlet var city2StackView: UIStackView!

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        pinBackground(backgroundView, to: city1StackView)
        pinBackground(backgroundView, to: city2StackView)
    }

    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
}

extension UIView {
    public func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
}

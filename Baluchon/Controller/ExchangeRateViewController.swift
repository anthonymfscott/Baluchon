//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet var inputRate: UITextField!
    @IBOutlet var resultRate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        ExchangeRateService.shared.getRate { result in
            switch result {
            case .success(let rate):
                self.updateUI(with: rate)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(with rate: ExchangeRate) {
//        resultRate.text = rate.rates["EUR"]!
    }
}


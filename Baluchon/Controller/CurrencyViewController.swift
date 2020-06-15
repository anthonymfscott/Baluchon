//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    @IBOutlet var inputRate: UITextField!
    @IBOutlet var resultRate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        convert()
    }

    @IBAction func baluchonGreenTapped(_ sender: UIButton) {
        convert()
    }

    private func convert() {
        CurrencyService.shared.getRate { result in
            switch result {
            case .success(let currency):
                self.updateUI(with: currency)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(with currency: Currency) {
        if let result = calculateEuroValue(with: currency) {
            resultRate.text = "\(result)"
        }
    }

    private func calculateEuroValue(with currency: Currency) -> Float? {
        var result: Float?

        if let value = inputRate.text {
            if let floatValue = Float(value) {
                result = floatValue / currency.rates["USD"]!
            }
        }

        return result?.roundedToSecondDecimal
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputRate.resignFirstResponder()
    }
}

//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    @IBOutlet private var currencyView1: CurrencyView!
    @IBOutlet private var currencyView2: CurrencyView!
    @IBOutlet private var baluchonView: BaluchonView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyView1.inputValueText = ""
        currencyView2.convertedValueText = ""
    }

    @IBAction private func baluchonGreenTapped(_ sender: UIButton) {
        currencyView1.inputValue?.resignFirstResponder()
        toggleLoadingState(shown: true)

        getCurrencyData()
    }

    private func getCurrencyData() {
        CurrencyService.shared.getRate { result in
            self.toggleLoadingState(shown: false)

            switch result {
            case .success(let currency):
                self.updateUI(with: currency)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
            }
        }
    }

    private func toggleLoadingState(shown: Bool) {
        baluchonView.isLoading = shown
        currencyView1.inputValue?.isEnabled = !shown
    }

    private func updateUI(with currency: Currency) {
        if let result = calculateEuroValue(with: currency) {
            currencyView2.convertedValueText = "\(result)"
        }
    }

    private func calculateEuroValue(with currency: Currency) -> Float? {
        var result: Float?

        if let value = currencyView1.inputValue?.text {
            if let floatValue = Float(value) {
                result = floatValue / currency.rates["USD"]!
            }
        }

        return result?.roundedToSecondDecimal
    }

    private func presentAlertController() {
        let ac = UIAlertController(title: "Network error", message: "Please check your Internet connection or try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

extension CurrencyViewController {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyView1.inputValue?.resignFirstResponder()
    }
}

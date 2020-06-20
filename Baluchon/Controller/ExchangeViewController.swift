//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    @IBOutlet private var exchangeView1: ExchangeView!
    @IBOutlet private var exchangeView2: ExchangeView!
    @IBOutlet private var baluchonView: BaluchonView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeView1.inputValueText = "1"
        exchangeView2.convertedValueText = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.baluchonView.baluchonButton.pulsate()
        }
    }

    @IBAction private func baluchonGreenTapped(_ sender: UIButton) {
        exchangeView1.inputValue?.resignFirstResponder()
        toggleLoadingState(shown: true)

        getCurrencyData()
    }

    private func getCurrencyData() {
        ExchangeService.shared.getExchange { result in
            self.toggleLoadingState(shown: false)

            switch result {
            case .success(let exchange):
                self.updateUI(with: exchange)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
            }
        }
    }

    private func toggleLoadingState(shown: Bool) {
        baluchonView.isLoading = shown
        exchangeView1.inputValue?.isEnabled = !shown
    }

    private func updateUI(with exchange: Exchange) {
        if let result = calculateEuroValue(with: exchange) {
            exchangeView2.convertedValueText = "\(result)"
        }
    }

    private func calculateEuroValue(with exchange: Exchange) -> Float? {
        var result: Float?

        if let value = exchangeView1.inputValue?.text {
            if let floatValue = Float(value) {
                result = floatValue / exchange.rates["USD"]!
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

extension ExchangeViewController {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        exchangeView1.inputValue?.resignFirstResponder()
    }
}

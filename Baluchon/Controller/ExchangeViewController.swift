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

        exchangeView1.currencyNameText = "USD"
        exchangeView2.currencyNameText = "EUR"

        exchangeView1.currencyIcon = UIImage(named: "dollar")!
        exchangeView2.currencyIcon = UIImage(named: "euro")!

        exchangeView1.inputValueText = "1"
        exchangeView2.convertedValueText = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
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
        if let result = convertValue(with: exchange) {
            exchangeView2.convertedValueText = "\(result)"
        }
    }

    private func convertValue(with exchange: Exchange) -> Float? {
        var result: Float?

        guard let value = exchangeView1.inputValue?.text, let floatValue = Float(value) else { return nil }

        if exchangeView1.currencyNameText == "USD" {
            result = floatValue / exchange.rates["USD"]!
        } else {
            result = floatValue * exchange.rates["USD"]!
        }

        return result?.roundedToSecondDecimal
    }

    @IBAction func swapCurrenciesTapped(_ sender: UIButton) {
        let currencyCopy = exchangeView1.currencyNameText
        exchangeView1.currencyNameText = exchangeView2.currencyNameText
        exchangeView2.currencyNameText = currencyCopy

        let imageCopy = exchangeView1.currencyIcon
        exchangeView1.currencyIcon = exchangeView2.currencyIcon
        exchangeView2.currencyIcon = imageCopy

        exchangeView1.inputValueText = "1"
        exchangeView2.convertedValueText = ""
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

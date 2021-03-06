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

        exchangeView1.currencyNameText = Constants.inputCurrency
        exchangeView2.currencyNameText = Constants.targetCurrency

        exchangeView1.currencyIcon = Images.dollarBadge
        exchangeView2.currencyIcon = Images.euroBadge

        exchangeView1.inputValueText = Constants.inputCurrencyValue
        exchangeView2.convertedValueText = ""

        baluchonView.shouldPulsate = true
    }

    @IBAction private func baluchonGreenTapped(_ sender: UIButton) {
        baluchonView.shouldPulsate = false
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
        } else {
            exchangeView2.convertedValueText = ""
        }
    }

    private func convertValue(with exchange: Exchange) -> Float? {
        var result: Float?

        guard let value = exchangeView1.inputValue?.text,
            let floatValue = Float(value), exchangeView1.inputValueText != "",
            let rate = exchange.rates[Constants.inputCurrency] else { return nil }

        if exchangeView1.currencyNameText == Constants.inputCurrency {
            result = floatValue / rate
        } else {
            result = floatValue * rate
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

        exchangeView1.inputValueText = Constants.inputCurrencyValue
        exchangeView2.convertedValueText = ""

        if !baluchonView.shouldPulsate {
            baluchonView.shouldPulsate = true
        }
    }
}

extension ExchangeViewController {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        exchangeView1.inputValue?.resignFirstResponder()
        exchangeView2.convertedValueText = ""

        if exchangeView1.inputValue?.text == "" {
            baluchonView.shouldPulsate = false
        } else if !baluchonView.shouldPulsate {
            baluchonView.shouldPulsate = true
        }
    }
}

//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    @IBOutlet var currencyView1: CurrencyView!
    @IBOutlet var currencyView2: CurrencyView!
    @IBOutlet var baluchonGreen: UIButton!
    @IBOutlet var baluchonStick: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        currencyView1.setDesign()
        currencyView2.setDesign()

        baluchonGreen.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonGreen.layer.shadowRadius = 0.7
        baluchonGreen.layer.shadowOpacity = 0.5
        baluchonGreen.layer.shadowOffset = CGSize(width: 2, height: 2)

        baluchonStick.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonStick.layer.shadowRadius = 0.7
        baluchonStick.layer.shadowOpacity = 0.5
        baluchonStick.layer.shadowOffset = CGSize(width: 2, height: 2)

        activityIndicator.isHidden = true
        
        currencyView1.inputValue?.text = nil
        currencyView2.convertedValue?.text = nil
    }

    @IBAction func baluchonGreenTapped(_ sender: UIButton) {
        currencyView1.inputValue?.resignFirstResponder()
        toggleActivityIndicator(shown: true)

        getCurrencyData()
    }

    private func getCurrencyData() {
        CurrencyService.shared.getRate { result in
            self.toggleActivityIndicator(shown: false)
            
            switch result {
            case .success(let currency):
                self.updateUI(with: currency)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
            }
        }
    }

    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        baluchonGreen.isEnabled = !shown
    }

    private func updateUI(with currency: Currency) {
        if let result = calculateEuroValue(with: currency) {
            currencyView2.convertedValue?.text = "\(result)"
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
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyView1.inputValue?.resignFirstResponder()
    }
}

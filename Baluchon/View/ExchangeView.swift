//
//  CurrencyView.swift
//  Baluchon
//
//  Created by anthonymfscott on 17/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class ExchangeView: BannerView {
    @IBOutlet private var currencyImage: UIImageView!
    @IBOutlet private var currencyName: UILabel!
    @IBOutlet var inputValue: UITextField?
    @IBOutlet private var convertedValue: UILabel?

    var currencyIcon: UIImage {
        didSet {
            currencyImage.image = currencyIcon
        }
    }

    var currencyNameText: String {
        didSet {
            currencyName.text = currencyNameText
        }
    }
    
    var inputValueText: String? {
        didSet {
            inputValue?.text = inputValueText
        }
    }

    var convertedValueText: String? {
        didSet {
            convertedValue?.text = convertedValueText
        }
    }
}

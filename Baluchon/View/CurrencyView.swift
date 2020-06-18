//
//  CurrencyView.swift
//  Baluchon
//
//  Created by anthonymfscott on 17/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class CurrencyView: BannerView {
    @IBOutlet var currencyImage: UIImageView!
    @IBOutlet var currencyName: UILabel!
    @IBOutlet var inputValue: UITextField?
    @IBOutlet private var convertedValue: UILabel?

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

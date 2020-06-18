//
//  WeatherView.swift
//  Baluchon
//
//  Created by anthonymfscott on 15/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class WeatherView: BannerView {
    @IBOutlet var cityImage: UIImageView!
    @IBOutlet var cityName: UILabel!
    @IBOutlet private var temperature: UILabel!
    @IBOutlet private var general: UILabel!
    @IBOutlet private var detail: UILabel!
    
    var temperatureText: String? = "" {
        didSet {
            temperature.text = temperatureText
        }
    }

    var generalText: String? {
        didSet {
            general.text = generalText
        }
    }

    var detailText: String? {
        didSet {
            detail.text = detailText
        }
    }
}

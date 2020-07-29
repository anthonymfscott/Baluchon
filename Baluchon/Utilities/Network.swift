//
//  Network.swift
//  Baluchon
//
//  Created by anthonymfscott on 14/07/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

enum Network {
    enum Weather {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = valueForAPIKey(named: "API_OpenWeathermap")
        static let parameters = "group?id=2800866,5128581&units=metric&appid="
    }
    enum Translation {
        static let baseUrl = "https://translation.googleapis.com/language/translate/v2"
        static let apiKey = valueForAPIKey(named: "API_GoogleTranslation")
    }
    enum Exchange {
        static let baseUrl = "http://data.fixer.io/api/"
        static let apiKey = valueForAPIKey(named: "API_Fixer")
        static let parameters = "latest?access_key="
    }
}

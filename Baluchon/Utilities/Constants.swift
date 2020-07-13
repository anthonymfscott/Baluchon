//
//  Constants.swift
//  Baluchon
//
//  Created by anthonymfscott on 09/07/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation
import UIKit

struct Constant {

}

enum Constants {
    static let originalCurrency = "USD"
// originalLanguage etc

    static let animationTimeInterval: TimeInterval = 2
}

//mettre dans fichiers à part
enum Strings {
    static let errorAlertTitle = "Network error"
}

enum Network {
    enum Weather {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = valueForAPIKey(named: "API_OpenWeathermap")
        static let parameters = "group?id=2800866,5128581&units=metric&appid=\(apiKey)"
    }
    enum Translation {
    }
    enum Exchange {
    }

}

enum Image {
    static let frenchFlag = #imageLiteral(resourceName: "france")
}

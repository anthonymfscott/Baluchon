//
//  Weather.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var city: String?
    var temperature: Float?
    var general: String?
    var detail: String?
    var icon: String?

    private var weather: [WeatherText]?

    enum CodingKeys: String, CodingKey {
        case weather, main, city = "name"
    }

    enum MainCodingKeys: String, CodingKey {
        case temperature = "temp"
    }

    struct WeatherText: Decodable {
        var main: String
        var description: String
        var icon: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)

        weather = try container.decode([WeatherText].self, forKey: .weather)
        general = weather?.first?.main
        detail = weather?.first?.description
        icon = weather?.first?.icon

        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        temperature = try main.decode(Float.self, forKey: .temperature)
    }
}

struct WeatherResponse: Decodable {
    let weatherArray: [Weather]

    enum CodingKeys: String, CodingKey {
        case weatherArray = "list"
    }
}

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
    var description: String?

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

        enum CodingKeys: String, CodingKey {
            case main, description
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(String.self, forKey: .city)
        weather = try container.decode([WeatherText].self, forKey: .weather)
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)

        temperature = try main.decode(Float.self, forKey: .temperature)
        general = weather?[0].main
        description = weather?[0].description
    }
}

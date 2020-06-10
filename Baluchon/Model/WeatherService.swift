//
//  WeatherService.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    private init() {}

    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    private let apiKey = "10f66a10b9cad69c5478404e51823159"

    private var task: URLSessionTask?

    func getWeather(cities: [String], callback: @escaping (Bool, [Weather?]?) -> Void) {
        var weathers: [Weather?]

        for city in cities {
            var weather: Weather?

            guard let url = URL(string: baseUrl + "\(city)&units=metric&appid=\(apiKey)") else {
                print("URL error")
                callback(false, nil)
                return
            }

            let session = URLSession(configuration: .default)

            task?.cancel()
            task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                        callback(false, nil)
                        return
                    }

                    guard let response = response as? HTTPURLResponse else {
                        print("Invalid response.")
                        callback(false, nil)
                        return
                    }

                    guard response.statusCode == 200 else {
                        print("Invalid status code.")
                        print(response.statusCode)
                        callback(false, nil)
                        return
                    }

                    guard let data = data else {
                        print("Invalid data.")
                        callback(false, nil)
                        return
                    }

                    do {
                        let decodedData = try JSONDecoder().decode(Weather.self, from: data)
                        weather = decodedData
                    } catch let error {
                        print("Decoding error: \(error)")
                        callback(false, nil)
                    }
                }
            }

            task?.resume()
            weathers.append(weather)
        }

        callback(true, weathers)
    }
}

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

    private let baseUrl = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "10f66a10b9cad69c5478404e51823159"

    private var task: URLSessionTask?

    func getWeather(completed: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        let url = URL(string: baseUrl + "group?id=2800866,5128581&units=metric&appid=\(apiKey)")!

        task?.cancel()

        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completed(.failure(.requestError(description: error.localizedDescription)))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completed(.failure(.invalidResponse))
                    return
                }

                guard response.statusCode == 200 else {
                    completed(.failure(.invalidStatusCode(statusCode: response.statusCode)))
                    return
                }

                guard let data = data else {
                    completed(.failure(.invalidData))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError(description: error.localizedDescription)))
                }
            }
        }

        task?.resume()
    }
}

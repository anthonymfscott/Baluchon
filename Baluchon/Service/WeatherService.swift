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

    private var session = URLSession(configuration: .default)
    private var task: URLSessionTask?

    init(session: URLSession) {
        self.session = session
    }

    func getWeather(completed: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        // guard let apiKey, url
        guard let url = URL(string: Network.Weather.baseUrl + Network.Weather.parameters) else { return }

        task?.cancel()

        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completed(.failure(.requestError(description: error.localizedDescription)))
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completed(.failure(.invalidResponse))
                    return
                }

                guard response.statusCode >= 200 && response.statusCode < 300 else {
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

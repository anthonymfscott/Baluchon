//
//  CurrencyService.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class CurrencyService {
    static let shared = CurrencyService()
    private init() {}

    private let baseUrl = "http://data.fixer.io/api/"
    private let apiKey = valueForAPIKey(named: "API_Fixer")

    private var task: URLSessionTask?

    func getRate(completed: @escaping (Result<Currency, NetworkError>) -> Void) {
        let url = URL(string: baseUrl + "latest?access_key=\(apiKey)")!

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

                guard response.statusCode >= 200 && response.statusCode < 300 else {
                    completed(.failure(.invalidStatusCode(statusCode: response.statusCode)))
                    return
                }

                guard let data = data else {
                    completed(.failure(.invalidData))
                    print("Invalid data.")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(Currency.self, from: data)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError(description: error.localizedDescription)))
                }
            }
        }

        task?.resume()
    }
}

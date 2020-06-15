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

    private let baseUrl = "https://data.fixer.io/api/"
    private let apiKey = "5d7d6c079441b3412bb1c51f01f231fc"

    private var task: URLSessionTask?

    func getRate(completed: @escaping (Result<Currency, NetworkError>) -> Void) {
//        let url = URL(string: baseUrl + "latest?access_key=\(apiKey)")

        let session = URLSession(configuration: .default)

        task?.cancel()
        
        task = session.dataTask(with: URL(string: "http://data.fixer.io/api/latest?access_key=5d7d6c079441b3412bb1c51f01f231fc")!) { (data, response, error) in
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
                    print("Invalid data.")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(Currency.self, from: data)
                    print(decodedData)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError(description: error.localizedDescription)))
                }
            }
        }

        task?.resume()
    }
}

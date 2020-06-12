//
//  ExchangeRateService.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class ExchangeRateService {
    static let shared = ExchangeRateService()
    private init() {}

    private let baseUrl = "https://data.fixer.io/api/latest?access_key="
    private let apiKey = "5d7d6c079441b3412bb1c51f01f231fc"

    private var task: URLSessionTask?

    func getRate(completed: @escaping (Bool, ExchangeRate?) -> Void) {
        guard let url = URL(string: baseUrl + apiKey) else {
            print("URL error")
            completed(false, nil)
            return
        }

        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completed(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("Invalid response.")
                    completed(false, nil)
                    return
                }

                guard response.statusCode == 200 else {
                    print("Invalid status code.")
                    print(response.statusCode)
                    completed(false, nil)
                    return
                }

                guard let data = data else {
                    print("Invalid data.")
                    completed(false, nil)
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    print(decodedData)
                    completed(true, decodedData)
                } catch let error {
                    print("Decoding error: \(error)")
                    completed(false, nil)
                }
            }
        }

        task?.resume()
    }
}

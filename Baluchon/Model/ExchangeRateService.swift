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

    private let baseUrl = "http://data.fixer.io/api/latest?access_key="
    private let apiKey = "5d7d6c079441b3412bb1c51f01f231fc"

    private var task: URLSessionTask?

    func getRate(from amount: Float) {
        guard let url = URL(string: baseUrl + apiKey) else {
            print("URL error")
            return
        }

        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        print("Request error")
                        return
                }

                guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                    print("JSON parsing error")
                    return
                }

                let dollars = responseJSON.rates["USD"]! * amount
                print("\(amount) euros = \(dollars) dollars")
            }
        }

        task?.resume()
    }
}

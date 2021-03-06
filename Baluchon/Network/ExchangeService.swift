//
//  ExchangeService.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class ExchangeService {
    static let shared = ExchangeService()
    private init() {}

    private var session = URLSession(configuration: .default)
    private var task: URLSessionTask?

    init(session: URLSession) {
        self.session = session
    }

    func getExchange(completed: @escaping (Result<Exchange, NetworkError>) -> Void) {
        guard let apiKey = Network.Exchange.apiKey, let url = URL(string: Network.Exchange.baseUrl + Network.Exchange.parameters + apiKey) else {
            completed(.failure(.invalidRequest))
            return
        }

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
                    let decodedData = try JSONDecoder().decode(Exchange.self, from: data)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError(description: error.localizedDescription)))
                }
            }
        }

        task?.resume()
    }
}

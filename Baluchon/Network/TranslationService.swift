//
//  TranslationService.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class TranslationService {
    static let shared = TranslationService()

    private let baseUrl: String

    private let session: URLSession
    private var task: URLSessionTask?

    init(session: URLSession = URLSession(configuration: .default), baseUrl: String = Network.Translation.baseUrl) {
        self.session = session
        self.baseUrl = baseUrl
    }

    func getTranslation(of inputText: String, to targetLanguage: String, completed: @escaping (Result<Translation, NetworkError>) -> Void) {
        guard let request = createTranslationRequest(inputText: inputText, targetLanguage: targetLanguage) else {
            completed(.failure(.invalidRequest))
            return
        }

        task?.cancel()
        
        task = session.dataTask(with: request) { (data, response, error) in
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
                    let decodedData = try JSONDecoder().decode(Translation.self, from: data)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError(description: error.localizedDescription)))
                }
            }
        }

        task?.resume()
    }

    private func createTranslationRequest(inputText: String, targetLanguage: String) -> URLRequest? {
        guard let url = URL(string: Network.Translation.baseUrl), let apiKey = Network.Translation.apiKey else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "q=\(inputText)&target=\(targetLanguage)&format=text&key=" + apiKey
        request.httpBody = body.data(using: .utf8)

        return request
    }
}

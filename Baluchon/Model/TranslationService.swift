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
    private init() {}

    private let baseUrl = "https://translation.googleapis.com/language/translate/v2"
    private let apiKey = valueForAPIKey(named: "API_GoogleTranslation")

    private var task: URLSessionTask?

    func getTranslation(of inputText: String, to targetLanguage: String, completed: @escaping (Result<Translation, NetworkError>) -> Void) {
        let request = createTranslationRequest(inputText: inputText, targetLanguage: targetLanguage)

        task?.cancel()
        
        task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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

    private func createTranslationRequest(inputText: String, targetLanguage: String) -> URLRequest {
        var request = URLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "POST"

        let body = "q=\(inputText)&target=\(targetLanguage)&source=fr&key=\(apiKey)"
        request.httpBody = body.data(using: .utf8)

        return request
    }
}

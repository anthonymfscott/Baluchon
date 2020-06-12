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
    private let apiKey = "AIzaSyD-7qmD0GVpwEepke0ZLHJZD2FS_X2SnvI"

    private var task: URLSessionTask?

    func getTranslation(of inputText: String, to targetLanguage: String, completed: @escaping (Result<Translation, NetworkError>) -> Void) {
        let request = createTranslationRequest(inputText: inputText, targetLanguage: targetLanguage)

        task?.cancel()
        task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completed(.failure(.requestError))
                    print(error)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    completed(.failure(.invalidResponse))
                    return
                }

                guard response.statusCode == 200 else {
                    completed(.failure(.invalidStatusCode))
                    print(response.statusCode)
                    return
                }

                guard let data = data else {
                    completed(.failure(.invalidData))
                    print("Invalid data.")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(Translation.self, from: data)
                    completed(.success(decodedData))
                } catch let error {
                    completed(.failure(.decodingError))
                    print(error)
                }
            }
        }

        task?.resume()
    }

    private func createTranslationRequest(inputText: String, targetLanguage: String) -> URLRequest {
        var request = URLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "POST"

        let body = "q=\(inputText)&target=\(targetLanguage)&key=\(apiKey)"
        request.httpBody = body.data(using: .utf8)

        return request
    }
}

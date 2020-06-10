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

    private let baseUrl = "https://translation.googleapis.com/language/translate/v2?"
    private let apiKey = "AIzaSyD-7qmD0GVpwEepke0ZLHJZD2FS_X2SnvI"

    private var task: URLSessionTask?

    func getTranslation(of text: String, to targetLanguage: String) {
        guard let url = URL(string: baseUrl + "q=\(text)&target=\(targetLanguage)&key=\(apiKey)") else {
            print("URL error")
            return
        }

        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("Invalid response.")
                    return
                }

                guard response.statusCode == 200 else {
                    print("Invalid status code.")
                    print(response.statusCode)
                    return
                }

                guard let data = data else {
                    print("Invalid data.")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(Translation.self, from: data)
                    print(decodedData.data.translations[0]["translatedText"]!)
                } catch let error {
                    print("Decoding error: \(error)")
                }
            }
        }

        task?.resume()
    }
}

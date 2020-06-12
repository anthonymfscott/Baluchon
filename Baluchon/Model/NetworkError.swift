//
//  NetworkError.swift
//  Baluchon
//
//  Created by anthonymfscott on 12/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case requestError(description: String)
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case decodingError(description: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .requestError(let description): return "Unable to complete the request: \(description)"
        case .invalidResponse: return "Invalid response"
        case .invalidStatusCode(let statusCode): return "Invalid status code: \(statusCode)"
        case .invalidData: return "Invalid data"
        case .decodingError(let description): return "Decoding error: \(description)"
        }
    }
}

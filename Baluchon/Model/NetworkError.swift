//
//  NetworkError.swift
//  Baluchon
//
//  Created by anthonymfscott on 12/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case requestError = "Unable to complete the request."
    case invalidResponse = "Invalid response."
    case invalidStatusCode = "Invalid status code."
    case invalidData = "Invalid data."
    case decodingError = "Decoding error."
}

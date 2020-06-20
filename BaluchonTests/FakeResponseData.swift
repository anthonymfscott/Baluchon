//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by anthonymfscott on 20/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

class FakeResponseData {
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var exchangeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let incorrectData = "error".data(using: .utf8)

    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!

    class ServiceError: Error {}
    static let error = ServiceError()
}

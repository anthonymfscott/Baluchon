//
//  TranslationServiceTestCase.swift
//  BaluchonTests
//
//  Created by anthonymfscott on 20/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

@testable import Baluchon
import XCTest

class TranslationServiceTestCase: XCTestCase {
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(of: "Bonjour", to: "en") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(of: "Bonjour", to: "en") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(of: "Bonjour", to: "en") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(of: "Bonjour", to: "en") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translationService.getTranslation(of: "Bonjour", to: "en") { result in
            switch result {
            case .success(let translation):
                XCTAssertNotNil(translation)

                let translatedText = "To be, or not to be: that is the question."
                XCTAssertEqual(translatedText, translation.translatedText)
            case .failure(_):
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

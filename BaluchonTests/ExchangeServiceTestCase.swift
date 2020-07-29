//
//  ExchangeServiceTestCase.swift
//  BaluchonTests
//
//  Created by anthonymfscott on 20/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

@testable import Baluchon
import XCTest

class ExchangeServiceTestCase: XCTestCase {
    func testGetExchangeShouldPostFailedCallbackIfError() {
        let exchangeService = ExchangeService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        exchangeService.getExchange { result in
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

    func testGetExchangeShouldPostFailedCallbackIfNoData() {
        let exchangeService = ExchangeService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        exchangeService.getExchange { result in
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

    func testGetExchangeShouldPostFailedCallbackIfIncorrectResponse() {
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        exchangeService.getExchange { result in
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

    func testGetExchangeShouldPostFailedCallbackIfIncorrectData() {
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        exchangeService.getExchange { result in
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
        let exchangeService = ExchangeService(session: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getExchange { result in
            switch result {
            case .success(let exchange):
                XCTAssertNotNil(exchange)

                let usd: Float = 1.117735
                XCTAssertEqual(usd, exchange.rates["USD"]!)
            case .failure(_):
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

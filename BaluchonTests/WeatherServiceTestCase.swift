//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by anthonymfscott on 20/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

@testable import Baluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
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

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
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

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
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

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
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

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                XCTAssertNotNil(weatherResponse)

                let temperature1: Float = 21.84
                let general1 = "Clouds"
                let detail1 = "scattered clouds"
                let temperature2: Float = 23.54
                let general2 = "Clear"
                let detail2 = "clear sky"

                let weatherData1 = weatherResponse.weatherArray.first
                let weatherData2 = weatherResponse.weatherArray.last

                XCTAssertEqual(temperature1, weatherData1?.temperature)
                XCTAssertEqual(general1, weatherData1?.general)
                XCTAssertEqual(detail1, weatherData1?.detail)
                XCTAssertEqual(temperature2, weatherData2?.temperature)
                XCTAssertEqual(general2, weatherData2?.general)
                XCTAssertEqual(detail2, weatherData2?.detail)

            case .failure(_):
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}

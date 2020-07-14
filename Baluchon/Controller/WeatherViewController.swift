//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 05/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet private var weatherView1: WeatherView!
    @IBOutlet private var weatherView2: WeatherView!
    @IBOutlet private var baluchonView: BaluchonView!

    @IBOutlet var latestUpdateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherView1.temperatureText = ""
        weatherView1.generalText = ""
        weatherView1.detailText = ""

        weatherView2.temperatureText = ""
        weatherView2.generalText = ""
        weatherView2.detailText = ""

        weatherView1.weatherImage.image = nil
        weatherView2.weatherImage.image = nil

        latestUpdateLabel.text = ""

        baluchonView.shouldPulsate = true
    }

    @IBAction private func baluchonRedTapped(_ sender: UIButton) {
        baluchonView.shouldPulsate = false
        toggleLoadingState(shown: true)
        getWeatherData()
    }

    private func getWeatherData() {
        WeatherService.shared.getWeather() { [weak self] result in
            DispatchQueue.main.async {
                self?.toggleLoadingState(shown: false)

                switch result {
                case .success(let weatherResponse):
                    self?.updateUI(with: weatherResponse)
                case .failure(let error):
                    self?.presentAlertController()
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func toggleLoadingState(shown: Bool) {
        baluchonView.isLoading = shown
    }

    private func updateUI(with weatherResponse: WeatherResponse) {
        let weatherData1 = weatherResponse.weatherArray.first
        let weatherData2 = weatherResponse.weatherArray.last

        update(weatherView1, with: weatherData1)
        update(weatherView2, with: weatherData2)

        showHour()
    }

    private func update(_ weatherView: WeatherView, with weatherData: Weather?) {
        if let temperature = weatherData?.temperature?.rounded().convertedToInt {
            weatherView.temperatureText = String(temperature) + Strings.celsiusLabel
        }
        weatherView.generalText = weatherData?.general
        weatherView.detailText = weatherData?.detail
        if let icon = weatherData?.icon {
            weatherView.weatherImage.downloaded(from: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        }
    }

    private func showHour() {

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none

        latestUpdateLabel.text = Strings.updateLabel + dateFormatter.string(from: Date())
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherView1.temperatureText = ""
        weatherView1.generalText = ""
        weatherView1.detailText = ""

        weatherView2.temperatureText = ""
        weatherView2.generalText = ""
        weatherView2.detailText = ""
    }

    @IBAction private func baluchonRedTapped(_ sender: UIButton) {
        toggleLoadingState(shown: true)
        getWeatherData()
    }

    private func getWeatherData() {
        WeatherService.shared.getWeather() { result in
            self.toggleLoadingState(shown: false)

            switch result {
            case .success(let weatherResponse):
                self.updateUI(with: weatherResponse)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
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
    }

    private func update(_ weatherView: WeatherView, with weatherData: Weather?) {
        if let temperature = weatherData?.temperature?.roundedToFirstDecimal {
            weatherView.temperatureText = "\(temperature)°C"
        }
        weatherView.generalText = weatherData?.general
        weatherView.detailText = weatherData?.detail
    }

    private func presentAlertController() {
        let ac = UIAlertController(title: "Network error", message: "Please check your Internet connection or try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

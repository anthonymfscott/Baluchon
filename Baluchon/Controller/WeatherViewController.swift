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

    private var baluchonShouldPulsate = true

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

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.baluchonView.baluchonButton.pulsate()
        }
    }

    @IBAction private func baluchonRedTapped(_ sender: UIButton) {
        toggleLoadingState(shown: true)
        getWeatherData()
        showHour()
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
        if let temperature = weatherData?.temperature?.rounded().intString {
            weatherView.temperatureText = "\(temperature)°C"
        }
        weatherView.generalText = weatherData?.general
        weatherView.detailText = weatherData?.detail
        if let icon = weatherData?.icon {
            weatherView.weatherImage.downloaded(from: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        }
    }

    private func showHour() {
        let hourString: String
        let minuteString: String

        let hour = Calendar.current.component(.hour, from: Date())

        if hour < 10 {
            hourString = "0\(hour)"
        } else {
            hourString = "\(hour)"
        }

        let minute = Calendar.current.component(.minute, from: Date())

        if minute < 10 {
            minuteString = "0\(minute)"
        } else {
            minuteString = "\(minute)"
        }

        latestUpdateLabel.text = "Last updated: \(hourString):\(minuteString)"
    }

    private func presentAlertController() {
        let ac = UIAlertController(title: "Network error", message: "Please check your Internet connection or try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

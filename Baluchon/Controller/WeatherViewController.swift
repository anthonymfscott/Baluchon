//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 05/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var weatherView1: WeatherView!
    @IBOutlet var weatherView2: WeatherView!
    @IBOutlet var baluchonRed: UIButton!
    @IBOutlet var baluchonStick: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        reset()
    }

    private func reset() {
        weatherView1.setDesign()
        weatherView2.setDesign()

        baluchonRed.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonRed.layer.shadowRadius = 0.7
        baluchonRed.layer.shadowOpacity = 0.5
        baluchonRed.layer.shadowOffset = CGSize(width: 2, height: 2)

        baluchonStick.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonStick.layer.shadowRadius = 0.7
        baluchonStick.layer.shadowOpacity = 0.5
        baluchonStick.layer.shadowOffset = CGSize(width: 2, height: 2)

        activityIndicator.isHidden = true

        weatherView1.temperature.text = ""
        weatherView1.general.text = ""
        weatherView1.detail.text = ""

        weatherView2.temperature.text = ""
        weatherView2.general.text = ""
        weatherView2.detail.text = ""
    }

    @IBAction func baluchonRedTapped(_ sender: UIButton) {
        getWeatherData()
    }

    private func getWeatherData() {
        WeatherService.shared.getWeather() { result in
            switch result {
            case .success(let weatherResponse):
                self.updateUI(with: weatherResponse)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(with weatherResponse: WeatherResponse) {
        let weatherData1 = weatherResponse.weatherArray[0]
        let weatherData2 = weatherResponse.weatherArray[1]

        update(weatherView1, with: weatherData1)
        update(weatherView2, with: weatherData2)
    }

    private func update(_ weatherView: WeatherView, with weatherData: Weather) {
        weatherView.cityName.text = weatherData.city?.uppercased()
        if let temperature = weatherData.temperature?.roundedToFirstDecimal {
            weatherView.temperature.text = "\(temperature)°C"
        }
        weatherView.general.text = weatherData.general
        weatherView.detail.text = weatherData.description
    }

    private func presentAlertController() {
        let ac = UIAlertController(title: "Network error", message: "Please check your Internet connection or try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 05/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var weather1City: UILabel!
    @IBOutlet var weather1Temperature: UILabel!
    @IBOutlet var weather1Main: UILabel!
    @IBOutlet var weather1Description: UILabel!

    @IBOutlet var weather2City: UILabel!
    @IBOutlet var weather2Temperature: UILabel!
    @IBOutlet var weather2Main: UILabel!
    @IBOutlet var weather2Description: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        weather1Temperature.text = ""
        weather1Main.text = ""
        weather1Description.text = ""

        weather2Temperature.text = ""
        weather2Main.text = ""
        weather2Description.text = ""
    }

    @IBAction func baluchonRedTapped(_ sender: UIButton) {
        getWeather()
    }

    private func getWeather() {
        WeatherService.shared.getWeather() { result in
            switch result {
            case .success(let weatherResponse):
                self.updateUI(with: weatherResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(with weatherResponse: WeatherResponse) {
        let weather1 = weatherResponse.weatherArray[0]
        let weather2 = weatherResponse.weatherArray[1]

        weather1City.text = weather1.city?.uppercased()
        if let temperature = weather1.temperature?.roundedToFirstDecimal {
            weather1Temperature.text = "\(temperature)°C"
        }
        weather1Main.text = weather1.general
        weather1Description.text = weather1.description

        weather2City.text = weather2.city?.uppercased()
        if let temperature = weather2.temperature?.roundedToFirstDecimal {
            weather2Temperature.text = "\(temperature)°C"
        }
        weather2Main.text = weather2.general
        weather2Description.text = weather2.description
    }
}

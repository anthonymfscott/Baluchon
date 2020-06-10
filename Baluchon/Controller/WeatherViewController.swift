//
//  ViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 05/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var city1Temperature: UILabel!
    @IBOutlet var city1Main: UILabel!
    @IBOutlet var city1Description: UILabel!
    @IBOutlet var city2Temperature: UILabel!
    @IBOutlet var city2Main: UILabel!
    @IBOutlet var city2Description: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        getWeather(cities: ["Brussels", "New+York"])
//        getWeather(city: "New+York")
    }

    private func getWeather(cities: [String]) {
        WeatherService.shared.getWeather(cities: cities) { (success, weathers) in
            if success, let weathers = weathers {
                self.update(weather: weathers[0], city: cities[0])
                self.update(weather: weathers[1], city: cities[1])
            }
        }
    }

    private func update(weather: Weather?, city: String) {
        if city == "Brussels" {
            if let temperature = weather?.temperature {
                city1Temperature.text = "\(temperature)°C"
            }
            city1Main.text = weather?.general
            city1Description.text = weather?.description
        } else {
            if let temperature = weather?.temperature {
                city2Temperature.text = "\(temperature)°C"
            }
            city2Main.text = weather?.general
            city2Description.text = weather?.description
        }
    }
}

//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet var inputRate: UITextField!
    @IBOutlet var resultRate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        ExchangeRateService.shared.getRate { (success, rate) in
//            if success, let rate = rate {
//                let result = rate.rates["USD"]!
//                self.resultRate.text = "\(result)"
//            }
//        }
    }
}


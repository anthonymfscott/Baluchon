//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var translationView1: TranslationView!
    @IBOutlet var translationView2: TranslationView!
    @IBOutlet var baluchonBlue: UIButton!
    @IBOutlet var baluchonStick: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        translationView1.setDesign()
        translationView2.setDesign()

        baluchonBlue.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonBlue.layer.shadowRadius = 0.7
        baluchonBlue.layer.shadowOpacity = 0.5
        baluchonBlue.layer.shadowOffset = CGSize(width: 2, height: 2)

        baluchonStick.layer.shadowColor = CGColor(genericGrayGamma2_2Gray: 0.1, alpha: 0.5)
        baluchonStick.layer.shadowRadius = 0.7
        baluchonStick.layer.shadowOpacity = 0.5
        baluchonStick.layer.shadowOffset = CGSize(width: 2, height: 2)

        activityIndicator.isHidden = true

        translationView1.inputText?.text = nil
        translationView2.translatedText?.text = nil
    }

    @IBAction private func baluchonBlueTapped(_ sender: UIButton) {
        translationView1.inputText?.resignFirstResponder()
        if let input = translationView1.inputText?.text {
             translate(input, to: "en")
        }
    }

    private func translate(_ inputText: String, to targetlanguage: String) {
        TranslationService.shared.getTranslation(of: inputText, to: targetlanguage) { result in
            switch result {
            case .success(let translation):
                self.updateUI(with: translation)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func updateUI(with translation: Translation) {
        translationView2.translatedText?.text = translation.translatedText
    }

    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationView1.inputText?.resignFirstResponder()
    }
}

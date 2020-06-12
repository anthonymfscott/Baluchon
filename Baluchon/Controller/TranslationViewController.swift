//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {
    @IBOutlet private var inputText: UITextView!
    @IBOutlet private var resultText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func baluchonBlueTapped(_ sender: UIButton) {
        translate(inputText.text, to: "en")
    }

    private func translate(_ inputText: String, to targetlanguage: String) {
        TranslationService.shared.getTranslation(of: inputText, to: targetlanguage) { result in
            switch result {
            case .success(let translation):
                self.updateUI(with: translation)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

    private func updateUI(with translation: Translation) {
        resultText.text = translation.translatedText
    }

    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputText.resignFirstResponder()
    }
}

//
//  TranslationViewController.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {
    @IBOutlet private var translationView1: TranslationView!
    @IBOutlet private var translationView2: TranslationView!
    @IBOutlet private var baluchonView: BaluchonView!

    override func viewDidLoad() {
        super.viewDidLoad()

        translationView1.languageNameText = "FR"
        translationView2.languageNameText = "EN"

        translationView1.languageIcon = UIImage(named: "france")
        translationView2.languageIcon = UIImage(named: "uk")

        translationView1.inputText = "Où se trouve la gare svp ?"
        translationView2.translatedText = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.baluchonView.baluchonButton.pulsate()
        }
    }

    @IBAction private func baluchonBlueTapped(_ sender: UIButton) {
        translationView1.input?.resignFirstResponder()
        toggleLoadingState(shown: true)

        if let input = translationView1.input?.text {
             getTranslationData(input, to: "en")
        }
    }

    private func getTranslationData(_ inputText: String, to targetlanguage: String) {
        TranslationService.shared.getTranslation(of: inputText, to: targetlanguage) { result in
            self.toggleLoadingState(shown: false)

            switch result {
            case .success(let translation):
                self.updateUI(with: translation)
            case .failure(let error):
                self.presentAlertController()
                print(error.localizedDescription)
            }
        }
    }

    private func toggleLoadingState(shown: Bool) {
        baluchonView.isLoading = shown
        translationView1.input?.isEditable = !shown
    }

    private func updateUI(with translation: Translation) {
        translationView2.translatedText = translation.translatedText
    }

    @IBAction func swapLanguagesTapped(_ sender: UIButton) {
        let languageCopy = translationView1.languageNameText
        translationView1.languageNameText = translationView2.languageNameText
        translationView2.languageNameText = languageCopy

        let imageCopy = translationView1.languageIcon
        translationView1.languageIcon = translationView2.languageIcon
        translationView2.languageIcon = imageCopy
    }

    private func presentAlertController() {
        let ac = UIAlertController(title: "Network error", message: "Please check your Internet connection or try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}

extension TranslationViewController: UITextViewDelegate {
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        translationView1.input?.resignFirstResponder()
    }

//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        translationView1.input?.resignFirstResponder()
//        return true
//    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            translationView1.input?.resignFirstResponder()
            return false
        }
        return true
    }
}

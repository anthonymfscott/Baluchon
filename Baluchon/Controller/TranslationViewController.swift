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
        
        translationView1.inputText = nil
        translationView2.translatedText = nil
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

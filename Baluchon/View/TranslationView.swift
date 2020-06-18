//
//  TranslationView.swift
//  Baluchon
//
//  Created by anthonymfscott on 17/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

class TranslationView: BannerView {
    @IBOutlet var languageImage: UIImageView!
    @IBOutlet var languageName: UILabel!
    @IBOutlet var input: UITextView?
    @IBOutlet private var translation: UILabel?

    var inputText: String? {
        didSet {
            input?.text = inputText
        }
    }

    var translatedText: String? {
        didSet {
            translation?.text = translatedText
        }
    }
}

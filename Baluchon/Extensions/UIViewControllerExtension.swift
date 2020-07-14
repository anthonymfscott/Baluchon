//
//  UIViewControllerExtension.swift
//  Baluchon
//
//  Created by anthonymfscott on 14/07/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertController() {
        let ac = UIAlertController(title: Strings.errorAlertTitle, message: Strings.errorAlertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: Strings.errorAlertAction, style: .cancel))
        present(ac, animated: true)
    }
}

//
//  UIImageViewExtension.swift
//  Baluchon
//
//  Created by anthonymfscott on 14/07/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }

            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

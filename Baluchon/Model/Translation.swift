//
//  Translation.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

struct Translation: Codable {
    struct Data: Codable {
        let translations: [[String: String]]
    }
    let data: Data
}

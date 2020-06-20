//
//  Exchange.swift
//  Baluchon
//
//  Created by anthonymfscott on 08/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

struct Exchange: Decodable {
    let rates: [String: Float]
}

//
//  ApiKeys.swift
//  Baluchon
//
//  Created by anthonymfscott on 19/06/2020.
//  Copyright © 2020 Anthony Scott. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}

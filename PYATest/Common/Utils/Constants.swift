//
//  Constants.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

struct Constants {
    struct Keychain {
        static let ACCESS_TOKEN = "ACCESS_TOKEN"
    }
    
    struct API {
        static let baseURL = Bundle.main.infoDictionary!["SERVER_URL"] as! String
        static let MAX_RESULTS = 50
        static let COUNTRY_CODE = 1
    }
}

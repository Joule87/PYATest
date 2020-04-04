//
//  AccessToken.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

struct AccessToken: Codable {
    var accessToken: String
  
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

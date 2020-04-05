//
//  Restaurant.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

struct Restaurant : Codable {
    
    var coordinates: String
    var name: String
    var ratingScore: String
    
    init(coordinates: String, name: String, ratingScore: String) {
        self.coordinates = coordinates
        self.name = name
        self.ratingScore = ratingScore
    }
    
}

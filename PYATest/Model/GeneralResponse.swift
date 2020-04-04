//
//  GeneralResponse.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

class GeneralResponse<T: Codable>: Codable {
    
    var data: [T]
    
    init(data: [T]) {
        self.data = data
    }
    
}

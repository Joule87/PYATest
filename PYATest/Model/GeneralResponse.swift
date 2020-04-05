//
//  GeneralResponse.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

class GeneralResponse<T: Codable>: Codable {
    
    var total: Int
    var data: [T]
    
    init(total: Int, data: [T]) {
        self.total = total
        self.data = data
    }
    
}

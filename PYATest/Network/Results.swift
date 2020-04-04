//
//  Results.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

public enum Results<Value> where Value: Codable {
    case success(Value)
    case failure(error: Error, data: Data?)
}

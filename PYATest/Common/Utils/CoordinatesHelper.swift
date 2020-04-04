//
//  CoordinatesHelper.swift
//  PYATest
//
//  Created by Julio Collado on 4/3/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

struct CoordinatesHelper {
    static func getCoordinates(from value: String) -> (latitud: Double, longitud: Double)? {
        let coordinates = value.split(separator: ",")
        guard let latitud = Double(coordinates[0]), let longitud = Double(coordinates[1]) else { return nil }
        return (latitud, longitud)
    }
}

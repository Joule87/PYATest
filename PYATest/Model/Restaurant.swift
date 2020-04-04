//
//  Restaurant.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

//TODO:- Para el parsear la informacion proveniente del servidor usaria tres objetos (RestauranteDTO, RestauranteDTOMapper, y Restaurant) de esta manera cualquier cambio en la del servidor no afectaria mi modelo de negocio. Por cuestion de tiempo lo hago de la manera a continuacion.

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

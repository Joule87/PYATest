//
//  RestaurantAPIProtocol.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

protocol RestaurantAPIProtocol {
    var restaurantAPI: RestaurantAPI { get set }
    init(restaurantAPI: RestaurantAPI)
    func getRestaurantList(on coordinates: String, offset: Int, completion: @escaping (Results<GeneralResponse<Restaurant>>) -> ())
}

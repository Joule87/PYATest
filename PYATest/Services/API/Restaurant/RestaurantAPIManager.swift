//
//  RestaurantAPIManager.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

class RestaurantAPIManager: RestaurantAPIProtocol {
    var restaurantAPI: RestaurantAPI
    
    required init(restaurantAPI: RestaurantAPI) {
        self.restaurantAPI = restaurantAPI
    }
    
    func getRestaurantList(on coordinates: String, offset: Int, completion: @escaping (Results<GeneralResponse<Restaurant>>) -> ()) {
        let request = restaurantAPI.getRestaurantDataRequest(coordinaates: coordinates, offset: offset)
        AlamofireRequest.createObjectRequest(request: request) { result in
            completion(result)
        }
    }
    
}

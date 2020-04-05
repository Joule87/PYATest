//
//  RestaurantAPI.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import Alamofire

class RestaurantAPI {
    
    private let credentiaManager = CredentialManager()
    
    func getRestaurantDataRequest(coordinaates: String, offset: Int) -> DataRequest {
        let fields = "name,ratingScore,coordinates"
        let restaurantAPIPath = "search/restaurants"
        let requestURL = "\(Constants.API.baseURL)/\(restaurantAPIPath)?point=\(coordinaates)&country=\(Constants.API.COUNTRY_CODE)&max=\(Constants.API.MAX_RESULTS)&offset=\(offset)&fields=\(fields)"
        let accessToken = credentiaManager.accessToken!
        let headerInformation = ["Authorization": "\(accessToken)", "Content-Type": "application/json"]
        let httpHeaders = HTTPHeaders(headerInformation)
        
        return AF.request(requestURL,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: httpHeaders)
    }
}

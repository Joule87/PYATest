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
        let max = 50
        let point = 1
        let fields = "name,ratingScore,coordinates"
        let apiRestaurantPath = "\(Constants.API.baseURL)/search/restaurants?point=\(coordinaates)&country=\(point)&max=\(max)&offset=\(offset)&fields=\(fields)"
        let accessToken = credentiaManager.accessToken!
        let headerInformation = ["Authorization": "\(accessToken)", "Content-Type": "application/json"]
        let httpHeaders = HTTPHeaders(headerInformation)
        
        return AF.request(apiRestaurantPath,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: httpHeaders)
    }
}

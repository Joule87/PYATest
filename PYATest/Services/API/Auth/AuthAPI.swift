//
//  AuthAPI.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI {
    
    func getAccessTokenDataRequest(clientId: String, clientSecret: String) -> DataRequest {
        
        let apiAuthPath = "\(Constants.API.baseURL)/tokens?clientId=\(clientId)&clientSecret=\(clientSecret)"
        
        return AF.request(apiAuthPath,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
}

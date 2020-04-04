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
    
    func getAccessTokenDataRequest() -> DataRequest {
        
        let appClientId = "trivia_f"
        let appClientSecret = "PeY@@Tr1v1@943"
        let apiAuthPath = "\(Constants.API.baseURL)/tokens?clientId=\(appClientId)&clientSecret=\(appClientSecret)"
        
        return AF.request(apiAuthPath,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
}

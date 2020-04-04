//
//  AuthAPIManager.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

class AuthAPIManager: AuthAPIProtocol {
    var authAPI: AuthAPI
    
    required init(authAPI: AuthAPI) {
        self.authAPI = authAPI
    }
    
    func getAccessToken(completion: @escaping (Results<AccessToken>) -> ()) {
        let request = authAPI.getAccessTokenDataRequest()
        AlamofireRequest.createObjectRequest(request: request) { result in
            completion(result)
        }
    }
    
}

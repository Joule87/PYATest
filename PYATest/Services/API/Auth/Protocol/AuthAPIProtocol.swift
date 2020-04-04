//
//  AuthAPIProtocol.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

protocol AuthAPIProtocol {
    var authAPI: AuthAPI { get set }
    init(authAPI: AuthAPI)
    func getAccessToken(completion: @escaping (Results<AccessToken>) -> ())
}

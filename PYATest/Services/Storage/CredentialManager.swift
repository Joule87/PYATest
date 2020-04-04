//
//  CredentialManager.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation

import Foundation

class CredentialManager {
    private let keychainManager = KeychainManager()
    
    var accessToken: String? {
        get {
            return keychainManager.getString(for: Constants.Keychain.ACCESS_TOKEN)
        }
        
        set {
            if let token = newValue {
                 keychainManager.set(token, for: Constants.Keychain.ACCESS_TOKEN)
                 return
            }
        }
    }

}

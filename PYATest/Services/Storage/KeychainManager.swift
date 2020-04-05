//
//  KeychainManager.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

struct KeychainManager {
    
    private let keychain = KeychainWrapper.standard
    
    func getString(for key: String) -> String? {
        return keychain.string(forKey: key)
    }
    
    func set(_ string: String, for key: String) {
        keychain.set(string, forKey: key)
    }
    
    func removeValue(for key: String) {
        keychain.removeObject(forKey: key)
    }
 
}

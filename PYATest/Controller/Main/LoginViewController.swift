//
//  LoginViewController.swift
//  PYATest
//
//  Created by Julio Collado on 4/5/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var clientIdTextView: UITextField!
    @IBOutlet weak var clientSecretTextView: UITextField!
    
    //MARK:- View Controller Functions
    
    func requestAccesToken(clientId: String, clientSecret: String) {
        showHud()
        let authAPI = AuthAPI()
        let authAPIManager = AuthAPIManager(authAPI: authAPI)
        authAPIManager.getAccessToken(clientId: clientId, clientSecret: clientSecret) { [weak self] (result) in
            guard let saveSelf = self else { return }
            switch result {
            case .success(let value):
                saveSelf.persistToken(value)
                saveSelf.didGetAccess(saveSelf)
                break
            case .failure(let error, _):
                AlertHelper.showBasicAlert(on: saveSelf, with: "Error", message: error.localizedDescription, actionTitle: "OK")
                break
            }
            saveSelf.hideHUD()
        }
    }
    
    private func persistToken(_ value: (AccessToken)) {
        let credentialManager = CredentialManager()
        credentialManager.accessToken = value.accessToken
    }
    
    private func didGetAccess(_ saveSelf: LoginViewController) {
        saveSelf.performSegue(withIdentifier: "MainSegue", sender: saveSelf)
    }
    
    //MARK:- Actions
    
    @IBAction func didTapGetAccessButton(_ sender: UIButton) {
        guard let clientId = clientIdTextView.text,
            let clientSecret = clientSecretTextView.text,
            !clientId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !clientId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                AlertHelper.showBasicAlert(on: self, with: "Alert", message: "Please, fill all fileds", actionTitle: "ok")
                return
        }
        requestAccesToken(clientId: clientId, clientSecret: clientSecret)
        
    }

}

//
//  BaseUIViewController.swift
//  PYATest
//
//  Created by Julio Collado on 4/5/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showHud(_ message: String? = "Loading..") {
        self.view.isUserInteractionEnabled = false
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }

    func hideHUD() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}

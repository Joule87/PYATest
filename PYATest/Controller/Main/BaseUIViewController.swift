//
//  BaseUIViewController.swift
//  PYATest
//
//  Created by Julio Collado on 4/5/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationManager.shared.checkLocationServices(viewController: self)
        LocationManager.shared.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          LocationManager.shared.delegate = nil
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

extension BaseUIViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        LocationManager.shared.checkLocationServices(viewController: self)
    }
    
}

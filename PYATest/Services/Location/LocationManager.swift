//
//  LocationManager.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager {
    
    static let shared = LocationManager()
    private let cLocationManager = CLLocationManager()
    var delegate: CLLocationManagerDelegate? {
        get {
            return cLocationManager.delegate
        }
        set {
            cLocationManager.delegate = newValue
        }
    }
    var currentCoordinates: CLLocationCoordinate2D? {
        get {
            return cLocationManager.location?.coordinate
        }
    }
    
    private init() {
        cLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(viewController: UIViewController) {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(viewController)
        } else {
            AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "Your device does not have location services enabled, this is required for the app proper functioning", actionTitle: "OK")
        }
    }
    
    func checkLocationAuthorization(_ viewController: UIViewController) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
            AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "For a proper app functioning grant access to this app for using device location services", actionTitle: "OK")
            break
        case .notDetermined:
            cLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "This app can not to use location services due to restrictions.", actionTitle: "OK")
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
}

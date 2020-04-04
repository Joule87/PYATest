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
    var setupDelegate: CLLocationManagerDelegate? {
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
            AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "Your device does not have location services enabled", actionTitle: "ok")
        }
    }
    
    func setDelegate(delegate: CLLocationManagerDelegate) {
        cLocationManager.delegate = delegate
    }
    
    func checkLocationAuthorization(_ viewController: UIViewController) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
             AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "Turn on location services on your device, please", actionTitle: "ok")
            break
        case .notDetermined:
            cLocationManager.requestWhenInUseAuthorization()
        case .restricted:
             AlertHelper.showBasicAlert(on: viewController, with: "Alert", message: "This app can not to use location services due to restriction.", actionTitle: "ok")
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
}

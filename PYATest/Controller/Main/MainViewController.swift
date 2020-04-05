//
//  ViewController.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: BaseUIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    
    private var coordinates: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = coordinates == nil ? "Location: Current Location" : nil
        requestAccesToken()
        LocationManager.shared.checkLocationServices(viewController: self)
        
    }
    
    func requestAccesToken() {
        showHud()
        let authAPI = AuthAPI()
        let authAPIManager = AuthAPIManager(authAPI: authAPI)
        authAPIManager.getAccessToken { (result) in
            switch result {
            case .success(let value):
                let credentialManager = CredentialManager()
                credentialManager.accessToken = value.accessToken
                break
            case .failure(let error, _):
                print("\(error.localizedDescription)")
                break
            }
            self.hideHUD()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? RestaurantListViewController else { return }
        let restaurantAPI = RestaurantAPI()
        destinationViewController.restaurantAPIManager = RestaurantAPIManager(restaurantAPI: restaurantAPI)
        destinationViewController.coordinates = coordinates ?? LocationManager.shared.currentCoordinates
    }
    
    @IBAction func didTapChangeLocation(_ sender: UIButton) {
        guard let selectedCoordinates = coordinates ?? LocationManager.shared.currentCoordinates else { return }
        let map = MapContainerView(viewController: self)
        map.delegate = self
        map.loadMap(on: selectedCoordinates)
    }
    
}

extension MainViewController: MapContainerViewDelegate {
    func didChangeLocation(placeMarked: CLPlacemark) {
        coordinates = placeMarked.location?.coordinate
        let streetNumber = placeMarked.subThoroughfare ?? ""
        let streetName = placeMarked.thoroughfare ?? ""
        let subLocality = placeMarked.subLocality ?? ""
        locationLabel.text = "Location: \(streetName) \(streetNumber) \(subLocality)"
    }
    
    
}

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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? RestaurantListViewController else { return }
        let restaurantAPI = RestaurantAPI()
        destinationViewController.restaurantAPIManager = RestaurantAPIManager(restaurantAPI: restaurantAPI)
        destinationViewController.coordinates = coordinates ?? LocationManager.shared.currentCoordinates
    }
    
    @IBAction func didTapChangeLocation(_ sender: UIButton) {
        guard let selectedCoordinates = coordinates ?? LocationManager.shared.currentCoordinates else {
            AlertHelper.showBasicAlert(on: self, with: "Error", message: "The app is not getting any coordinates from this device", actionTitle: "OK")
            return
        }
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

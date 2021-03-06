//
//  RestaurantListViewController.swift
//  PYATest
//
//  Created by Julio Collado on 4/2/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantListViewController: BaseUIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    //MARK:- Properties
    
    var coordinates: CLLocationCoordinate2D?
    var restaurantAPIManager: RestaurantAPIProtocol?
    
    private var restaurantList = [Restaurant]()
    private var totalRestaurants = 0
    //MARK:- View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showHud()
        getRestaurants(from: 0)
    }
    
    //MARK:- View Controller Functions
    
    private func setupUIElements() {
        restaurantTableView.register(UINib(nibName: RestaurantTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: RestaurantTableViewCell.cellIdentifier)
    }
    
    private func processResponse(_ value: (GeneralResponse<Restaurant>)) {
        totalRestaurants = value.total
        restaurantList.append(contentsOf: value.data)
        restaurantTableView.reloadData()
    }
    
    /// Gets all the restaurants near selected coordinates
    /// - Parameters:
    ///   - offset: Index of the element from which to obtain the results
    func getRestaurants(from offset: Int) {
        guard let coordinates = coordinates, let restaurantService = restaurantAPIManager else {
            AlertHelper.showBasicAlert(on: self, with: "Error", message: "The app is not getting any coordinates from this device", actionTitle: "OK")
            hideHUD()
            return
        }
        let latitudAndLongitude = "\(coordinates.latitude),\(coordinates.longitude)"
        restaurantService.getRestaurantList(on: latitudAndLongitude, offset: offset, completion: { [weak self] (result) in
            guard let saveSelf = self else { return}
            switch result {
            case .success(let value):
                saveSelf.processResponse(value)
                break
            case .failure(let error, data: _):
                AlertHelper.showBasicAlert(on: saveSelf, with: "Error", message: error.localizedDescription, actionTitle: "OK")
                break
            }
            saveSelf.hideHUD()
        })
    }
    
    func show(restaurant: Restaurant) {
        let map = MapContainerView(viewController: self)
        map.loadMap(on: restaurant)
    }
    
    //MARK:- Actions
    
    //MARK:- Navigation
    
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        let restaurant = restaurantList[indexPath.row]
        cell.nameLabel?.text = restaurant.name
        cell.scoreLabel?.text = "Score: \(restaurant.ratingScore)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRestaurant = restaurantList[indexPath.row]
        show(restaurant: selectedRestaurant)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (restaurantList.count - 15), totalRestaurants > restaurantList.count {
            let offset = restaurantList.count
            getRestaurants(from: offset)
        }
    }
    
}

//
//  MapContainerView.swift
//  PYATest
//
//  Created by Julio Collado on 4/3/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import UIKit
import MapKit

class MapContainerView: UIView {
    
    //MARK:- Properties
    
    private var parentView: UIViewController!
    private let map: MKMapView! = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.cornerRadius = 10
        return map
    }()
    
    private let closeButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "closeBoard"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        return button
    }()
    
    private let interrogationButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "question"), for: .normal)
        return button
    }()
    
    private let regionInMeters: Double = 500
    private var marker: CustomAnnotation?
    var delegate: MapContainerViewDelegate?
    
    //MARK:- Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainer()
        layoutMapView()
        layoutCloseButton()
    }
    
    convenience init(viewController: UIViewController) {
        self.init(frame: CGRect.zero)
        self.parentView = viewController
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    //MARK:- Functions
    
    private func setupContainer() {
        self.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    private func clearAnnotations() {
        if !map.annotations.isEmpty, let marker = self.marker {
            map.removeAnnotation(marker)
        }
    }
    
    @objc private func dismiss() {
        clearAnnotations()
        self.removeFromSuperview()
    }
    
    @objc private func didTapInterrogationButton() {
        AlertHelper.showBasicAlert(on: parentView, with: "Help", message: "Long press on the map to select a location", actionTitle: "Ok")
    }
    
    private func layoutCloseButton() {
        self.addSubview(closeButton)
        [closeButton.topAnchor.constraint(equalTo: map.topAnchor, constant: -23),
         closeButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: 23),
         closeButton.widthAnchor.constraint(equalToConstant: 50),
         closeButton.heightAnchor.constraint(equalToConstant: 50)].forEach{$0.isActive = true}
        addGestureRecodnizerOnCloseButton()
    }
    
    private func addGestureRecodnizerOnCloseButton() {
        let tapGestureToClose = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        closeButton.addGestureRecognizer(tapGestureToClose)
    }
    
    private func layoutInterrogationButton() {
        self.addSubview(interrogationButton)
        [interrogationButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -10),
         interrogationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -10),
         interrogationButton.widthAnchor.constraint(equalToConstant: 50),
         interrogationButton.heightAnchor.constraint(equalToConstant: 50)].forEach{$0.isActive = true}
        addGestureRecodnizerOnInterrogationButton()
    }
    
    private func addGestureRecodnizerOnInterrogationButton() {
        let tapGestureToClose = UITapGestureRecognizer(target: self, action: #selector(didTapInterrogationButton))
        interrogationButton.addGestureRecognizer(tapGestureToClose)
    }
    
    private func layoutMapView() {
        map.delegate = self
        addSubview(map)
        NSLayoutConstraint.activate([map.topAnchor.constraint(equalTo: self.topAnchor , constant: 100),
                                     map.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
                                     map.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
                                     map.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)])
        
    }
    
    private func layoutMapContainerView() {
        self.parentView.view.addSubview(self)
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: self.parentView.view.topAnchor, constant: 0),
                                     self.bottomAnchor.constraint(equalTo: self.parentView.view.bottomAnchor, constant: 0),
                                     self.leadingAnchor.constraint(equalTo: self.parentView.view.leadingAnchor, constant: 0),
                                     self.trailingAnchor.constraint(equalTo: self.parentView.view.trailingAnchor, constant: 0),])
        
        
    }
    
    private func addLongTapGestureOnMap() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureReconizer:)))
        longPressGestureRecognizer.minimumPressDuration = 0.2
        longPressGestureRecognizer.delaysTouchesBegan = true
        self.map.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    
    
    @objc private func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state == UIGestureRecognizer.State.ended {
            clearAnnotations()
            let touchLocation = gestureReconizer.location(in: map)
            let selectedLocation = map.convert(touchLocation,toCoordinateFrom: map)
            getPlaceMark(for: selectedLocation)
        }
    }
    
    func getPlaceMark(for selectedLocation: CLLocationCoordinate2D) {
        guard let delegate = delegate else { return }
        let geoCoder = CLGeocoder()
        let cLocation = CLLocation(latitude: selectedLocation.latitude, longitude: selectedLocation.longitude)
        geoCoder.reverseGeocodeLocation(cLocation) { [weak self] (placemarks, error) in
            guard let saveSelf = self else { return }
            if let _ = error {
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                delegate.didChangeLocation(placeMarked: placemark)
                saveSelf.addMarker(title: streetName, subtitle: streetNumber, selectedLocation)
            }
            
        }
        
    }
    
    func loadMap(on restaurant: Restaurant) {
        layoutMapContainerView()
        pin(restaurant: restaurant)
    }
    
    func loadMap(on coordinates: CLLocationCoordinate2D) {
        layoutMapContainerView()
        centerViewOn(coordinates)
        addLongTapGestureOnMap()
        layoutInterrogationButton()
    }
    
    private func pin(restaurant: Restaurant) {
        guard let coordinates = CoordinatesHelper.getCoordinates(from: restaurant.coordinates) else { return }
        
        guard let latitude = CLLocationDegrees(exactly: coordinates.latitud), let longitud = CLLocationDegrees(exactly: coordinates.longitud) else { return }
        
        let cLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitud)
        let name = restaurant.name
        let score = "Score: \(restaurant.ratingScore)"
        
        addMarker(title: name, subtitle: score, cLocationCoordinate2D)
        centerViewOn(cLocationCoordinate2D)
    }
    
    private func addMarker(title: String, subtitle: String, _ cLocationCoordinate2D: CLLocationCoordinate2D) {
        marker = CustomAnnotation(title: title, subtitle: subtitle, coordinate: cLocationCoordinate2D)
        if let marker = self.marker {
            marker.image = UIImage(named: "pin")
            map.addAnnotations([marker])
        }
    }
    
    private func centerViewOn(_ cLocationCoordinate2D: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: cLocationCoordinate2D, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        map.setRegion(region, animated: true)
    }
    
}

extension MapContainerView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CustomAnnotation {
            let identifier = "identifier"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = annotation.image
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 30)
            return annotationView
        }
        return nil
    }
    
}

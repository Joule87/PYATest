//
//  MapContainerViewDelegate.swift
//  PYATest
//
//  Created by Julio Collado on 4/4/20.
//  Copyright © 2020 Altimetrik. All rights reserved.
//

import Foundation
import MapKit

protocol MapContainerViewDelegate {
    func didChangeLocation(placeMarked: CLPlacemark)
}

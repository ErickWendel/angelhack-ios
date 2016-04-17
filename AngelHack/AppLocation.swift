//
//  AppLocation.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import Foundation
import CoreLocation

class AppLocation: NSObject {
    static let sharedInstance = AppLocation()
    var locationManager: CLLocationManager
    var latitude: String?
    var longitude: String?
    
    override init () {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
}



extension AppLocation: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latitude = String(format: "%.5f", (locations[0].coordinate.latitude))
        self.longitude = String(format: "%.5f", (locations[0].coordinate.longitude))
    }
}
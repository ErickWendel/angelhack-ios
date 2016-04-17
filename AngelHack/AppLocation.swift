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
    var locationManager: CLLocationManager?
    var latitude: String?
    var longitude: String?
    
    func start () {
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        self.locationManager!.requestAlwaysAuthorization()
    }
}



extension AppLocation: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            self.locationManager?.startUpdatingLocation()
            AppNotifications.showLoadingIndicator("Carregando dados de mercados...")
            AppData.getMarkets()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latitude = String(format: "%.3f", (locations[0].coordinate.latitude))
        self.longitude = String(format: "%.3f", (locations[0].coordinate.longitude))
    }
}
//
//  ViewController.swift
//  UserLocationMap
//
//  Created by Stephen Dowless on 1/22/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        configureMapView()
        enableLocationServices()
        centerMapOnUserLocation()
    }
    
   
    
    // MARK: - Helper Functions
    
    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        //mapView.delegate = self
        mapView.userTrackingMode = .follow
        
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate
            else { return }
        print(coordinate)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
    
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {

    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location auth status is RESTRICTED")
        case .denied:
            print("Location auth status is DENIED")
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            print("Test")
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}



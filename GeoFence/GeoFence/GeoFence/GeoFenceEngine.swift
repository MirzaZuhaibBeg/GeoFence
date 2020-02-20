//
//  GeoFenceEngine.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import UIKit
import CoreLocation

/**
 GeoFence Engine class which should implement Geo Fence Protocol to start and stop region monitoring
 */
open class GeoFenceEngine: NSObject, GeoFenceable, CLLocationManagerDelegate {
    
    weak var delegate: GeoFenceEngineDelegate?
    
    fileprivate var locationManager: CLLocationManager = CLLocationManager()

    fileprivate var geoFencingInProgress:Bool = false
    
    // MARK: GeoFence Protocol Methods
    public func initializeGeoFenceEngine() {
        self.locationManager.delegate = self
        self.startLocationTracking()
    }
    
    public func startMonitoring(regions:[GeoFenceRegion]) {
        // check if Geo Fence Engine can monitor regions
        if regions.count > 0, CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            self.monitorRegion(regions: regions)
        }
    }
    
    public func stopMonitoring() {
        // stop monitoring for all regions
        for  region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        geoFencingInProgress = false
        self.stopLocationUpdates()
        self.locationManager.delegate = nil
    }
    
    // MARK: Private  Methods
    fileprivate func startLocationTracking() {
        self.stopLocationUpdates()
        let locationStatus = CLLocationManager.locationServicesEnabled()
        if locationStatus {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            if (authorizationStatus != .denied && authorizationStatus != .restricted) {
                self.initiateLocationUpdates()
            }
        }
    }
    
    fileprivate func initiateLocationUpdates() {
        self.locationManager.pausesLocationUpdatesAutomatically = false
        if #available(iOS 9.0, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        }
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        self.startLocationUpdates()
    }
    
    fileprivate func startLocationUpdates() {
          self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    fileprivate func stopLocationUpdates() {
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: Location Manager Delegate Methods
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation:CLLocation = locations.last  else {
            return
        }
        
        if !geoFencingInProgress {
            geoFencingInProgress = true
            self.delegate?.geoFenceEngine(engine: self, didReceiveUserLocation: lastLocation)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.geoFenceEngine(engine: self, didFailWithError: error)
    }

    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        self.delegate?.geoFenceEngine(engine: self, monitoringDidFailFor: region, withError: error)
    }
   
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        self.delegate?.geoFenceEngine(engine: self, didStartMonitoringFor: region)
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.delegate?.geoFenceEngine(engine: self, didEnterRegion: region)
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
        self.delegate?.geoFenceEngine(engine: self, didExitRegion: region)
    }
    
    // MARK: Region Monitoring Helper Methods
    
    fileprivate func monitorRegion(regions: [GeoFenceRegion]) {
        // stop monitoring all regions
        for  region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        
        for geoFenceStore in regions {
            addRegionForMonitoring(geoFenceStore.identifier, latitude: geoFenceStore.latitude, longitude: geoFenceStore.longitude, regionRadius: geoFenceStore.radius)
        }
    }
    
    fileprivate func addRegionForMonitoring(_ title: String, latitude: Double, longitude: Double, regionRadius:Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let region = CLCircularRegion(center: coordinate, radius: regionRadius, identifier: title)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
    }
}

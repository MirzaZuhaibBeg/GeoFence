//
//  GeoFenceManager.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import UIKit
import CoreLocation

/**
GeoFence Manager class which manages the geo fence start and end event based on configuration
 */
class GeoFenceManager: GeoFenceEngineDelegate {
    
    static let sharedManager: GeoFenceManager = {
    
        let sharedManager = GeoFenceManager()
        return sharedManager
    }()

    var geoFenceEngine:GeoFenceEngine?
    
    var monitoredStores:[Store]?
    
    //MARK:- Geo Fence Start Stop Methods
    /**
     Method to start Geo Fence Manager, it will be invoked on start notification
     */
    internal func startGeoFenceManager() {

        if (self.geoFenceEngine == nil) {
            self.geoFenceEngine = GeoFenceEngine()
            self.geoFenceEngine?.delegate = self
        }
        
        self.geoFenceEngine?.initializeGeoFenceEngine()
    }
    
    /**
     Method to stop Geo Fence Manager, it will be invoked on stop notification
     */
    internal func stopGeoFenceManager() {
        geoFenceEngine?.stopMonitoring()
    }
    
    // MARK: Private Methods
    fileprivate func createGeoFence (stores: [Store], location: CLLocation) {
        
        var geoFenceStores:[GeoFenceRegion] = []
        let radius = 100
        for store in stores {
            let identifier = String(store.identifier)
            let geoFenceStore: GeoFenceRegion = GeoFenceStore(identifier: identifier, radius: Double(radius), latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
            geoFenceStores.append(geoFenceStore)
        }
        
        self.geoFenceEngine?.startMonitoring(regions: geoFenceStores)
    }
    
    // MARK: Geo Fence Engine Delegate Methods
    func geoFenceEngine(engine: GeoFenceEngine, didReceiveUserLocation location:CLLocation?) {
        guard let location = location else {
            return
        }
        
        var stores = [Store]()
        stores.append(Store(name: "store", identifier: "1", latitude: 28.6139, longitude: 77.209))
        // API call to fetch nearby stores and update stores
        
        self.monitoredStores = stores
        self.createGeoFence(stores: stores, location: location)
    }
    
    func geoFenceEngine(engine: GeoFenceEngine, didFailWithError error: Error) {
        /// To be implemented if error case need to be handled
    }
    
    func geoFenceEngine(engine: GeoFenceEngine, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        /// To be implemented if monitoring error case need to be handled
    }
    
    func geoFenceEngine(engine: GeoFenceEngine, didStartMonitoringFor region: CLRegion?) {
        /// To be implemented if start monitoring need to be handled
    }
    
    func geoFenceEngine(engine: GeoFenceEngine, didExitRegion region: CLRegion) {
        /// To be implemented if exit region monitoring is required
    }
    
    func geoFenceEngine(engine: GeoFenceEngine, didEnterRegion region: CLRegion) {
        /// To be implemented if enter region monitoring is required
    }
}

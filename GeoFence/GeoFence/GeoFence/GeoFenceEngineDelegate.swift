//
//  GeoFenceEngineDelegate.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import Foundation
import CoreLocation

/**
 GeoFence Engine Protocol to delegate location engine events to Geo Fence Manager class
 */
public protocol GeoFenceEngineDelegate : class {
    
    /**
     This method will send user location to manager
     - parameter engine: class confirming to this delegate
     - parameter location: user current location found
     */
    func geoFenceEngine(engine: GeoFenceEngine, didReceiveUserLocation location:CLLocation?)
        
    /**
     This method will notify exit inner region event to manager
     - parameter engine: class confirming to this delegate
     - parameter region: region that is exited
     */
    func geoFenceEngine(engine: GeoFenceEngine, didExitRegion region: CLRegion)
    
    /**
     This method will notify enter inner region event to manager
     - parameter engine: class confirming to this delegate
     - parameter region: region that is entered
     */
    func geoFenceEngine(engine: GeoFenceEngine, didEnterRegion region: CLRegion)
    
    /**
     This method will notify any error in location manager to engine
     - parameter engine: class confirming to this delegate
     - parameter error: error occured
     */
    func geoFenceEngine(engine: GeoFenceEngine, didFailWithError error: Error)
    
    /**
     This method will notify any error in monitoring of particular region to engine
     - parameter engine: class confirming to this delegate
     - parameter region: region in which error occured
     - parameter error: error occured
     */
    func geoFenceEngine(engine: GeoFenceEngine, monitoringDidFailFor region: CLRegion?, withError error: Error)
    
    /**
     This method will notify monitoring start of particular region to engine
     - parameter engine: class confirming to this delegate
     - parameter region: region in which monitoring started
     */
    func geoFenceEngine(engine: GeoFenceEngine, didStartMonitoringFor region: CLRegion?)
    
}

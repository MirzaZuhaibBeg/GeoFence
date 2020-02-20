//
//  GeoFenceProtocol.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import Foundation

/**
 GeoFence Protocol for handling start and stop geo fencing
 Class confirming GeoFence protocol should implement methods to start geo fence engine, start and stop monitoring
 */
public protocol GeoFenceable {

    /**
     Function will initialize the geo fence engine
     This method will be implemented by the geo fence engine class and will be used to initialize the geo fencing
     */
    func initializeGeoFenceEngine()
    
    /**
     Function will start the monitoring of geo fence regions
     This method will take the list of stores as arguments and will monitor those regions
     - parameter regions: regions to be monitored
     */
    func startMonitoring(regions:[GeoFenceRegion])
    
    /**
     Function will stop monitoring for all the regions being monitored
     This method will be implemented by the geo fence engine class and will be used to stop monitoring
     */
    func stopMonitoring()
}

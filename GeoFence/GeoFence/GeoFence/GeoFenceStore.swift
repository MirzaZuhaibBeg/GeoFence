//
//  FenceStore.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import UIKit
import CoreLocation

/**
 GeoFence Store Struct for saving geo fence store data
 */
public struct GeoFenceStore: GeoFenceRegion {
    
    /// A unique identifier to associate with the region object. You use this identifier to differentiate regions within your application. This value must not be nil.
    public var identifier: String
    
    /// The radius (measured in meters) that defines the geographic area’s outer boundary
    public var radius: CLLocationDistance
    
    /// The latitude in degrees.
    public var latitude: CLLocationDegrees
    
    /// The longitude in degrees.
    public var longitude: CLLocationDegrees
        
}

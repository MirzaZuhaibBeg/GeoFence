//
//  GeoFenceProtocol.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import Foundation
import CoreLocation

/**
GeoFence Region Protocol that a store representing region should implement
 */
public protocol GeoFenceRegion {
    
    /// A unique identifier to associate with the region object. You use this identifier to differentiate regions within your application. This value must not be nil.
    var identifier: String {get set}
    
    /// The radius (measured in meters) that defines the geographic area’s outer boundary
    var radius: CLLocationDistance {get set}
    
    /// The latitude in degrees.
    var latitude: CLLocationDegrees {get set}
    
    /// The longitude in degrees.
    var longitude: CLLocationDegrees {get set}
}

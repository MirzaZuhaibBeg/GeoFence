//
//  Store.swift
//  GeoFence
//
//  Created by Mirza Zuhaib Beg on 08/02/20.
//  Copyright © 2020 Mirza Zuhaib Beg. All rights reserved.
//

import Foundation

/**
 Store class will save Store info
 */
struct Store {
    
    /// name of store
    var name: String?
    
    /// A unique identifier for store.
    var identifier: String
    
    /// latitude of store.
    var latitude: Double = 0.0
    
    /// longitude of store.
    var longitude: Double = 0.0
}

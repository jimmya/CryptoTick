//
//  DataPoint.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 02/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class DataPoint {
    
    let timestamp: TimeInterval?
    let value: Double?
    
    init(timestamp: TimeInterval, value: Double) {
        self.timestamp = timestamp
        self.value = value
    }
}



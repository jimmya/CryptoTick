//
//  History.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 02/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class History: ALJSONAble {
    
    let marketCap: [DataPoint]?
    let price: [DataPoint]?
    let volume: [DataPoint]?
    
    init?(jsonData: JSON) {
        marketCap = jsonData["market_cap"].jsonArrayValue.flatMap { (point) -> DataPoint? in
            if let first = point[0].double, let second = point[1].double {
                return DataPoint(timestamp: first, value: second)
            }
            return nil
        }
        price = jsonData["price"].jsonArrayValue.flatMap { (point) -> DataPoint? in
            if let first = point[0].double, let second = point[1].double {
                return DataPoint(timestamp: first, value: second)
            }
            return nil
        }
        volume = jsonData["volume"].jsonArrayValue.flatMap { (point) -> DataPoint? in
            if let first = point[0].double, let second = point[1].double {
                return DataPoint(timestamp: first, value: second)
            }
            return nil
        }
    }
}

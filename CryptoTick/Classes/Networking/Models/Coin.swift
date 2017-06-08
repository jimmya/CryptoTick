//
//  Coin.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 31/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class Coin: ALJSONAble {
    
    let shortName: String
    let longName: String
    let position: Int
    var price: Double
    
    init?(jsonData: JSON) {
        if let shortName = jsonData["short"].string,
            let longName = jsonData["long"].string,
            let positionString = jsonData["position24"].string,
            let position = Int(positionString),
            let price = jsonData["price"].double {
            self.shortName = shortName
            self.longName = longName
            self.position = position
            self.price = price
        } else {
            return nil
        }
    }
    
    init?(dictionary: [String: Any]) {
        if let shortName = dictionary["short"] as? String,
            let longName = dictionary["long"] as? String,
            let positionString = dictionary["position24"] as? String,
            let position = Int(positionString),
            let price = dictionary["price"] as? Double {
            self.shortName = shortName
            self.longName = longName
            self.position = position
            self.price = price
        } else {
            return nil
        }
    }
}

extension Array where Element:Coin {
    
    mutating func updatePriceForCoin(withShortName shortName: String, newPrice: Double) {
        if let tradeCoin = self.filter({ (coin) -> Bool in
            return coin.shortName == shortName
        }).first {
            tradeCoin.price = newPrice
        }
    }
}

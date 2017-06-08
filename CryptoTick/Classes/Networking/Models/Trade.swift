//
//  Trade.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 31/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class Trade: ALJSONAble {
    
    let coinName: String?
    let coin: Coin?
    
    init?(dictionary: [String: Any]) {
        if let coinName = dictionary["coin"] as? String,
            let msgDict = dictionary["msg"] as? [String: Any],
            let coin = Coin(dictionary: msgDict) {
            self.coinName = coinName
            self.coin = coin
        } else {
            return nil
        }
    }
    
    init?(jsonData: JSON) {
        if let coinName = jsonData["coin"].string,
            let coin = Coin(jsonData: jsonData["msg"]) {
            self.coinName = coinName
            self.coin = coin
        } else {
            return nil
        }
    }
}

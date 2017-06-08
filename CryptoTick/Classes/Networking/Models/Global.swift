//
//  Global.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 31/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class Global: ALJSONAble {
    
    let btcPrice: Double?
    let btcCap: Double?
    let altCap: Double?
    let dom: Int?
    let bitnodesCount: Int?
    
    init?(jsonData: JSON) {
        btcPrice = jsonData["btcPrice"].double
        btcCap = jsonData["btcCap"].double
        altCap = jsonData["altCap"].double
        dom = jsonData["dom"].int
        bitnodesCount = jsonData["bitnodesCount"].int
    }
}


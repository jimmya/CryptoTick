//
//  Currency.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 30/05/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import SWXMLHash

struct Currency {
    
    let name: String?
    let price: Double?
    let symbol: String?
    let date: Date?
    
    var cleanSymbol: String {
        return symbol?.replacingOccurrences(of: "=X", with: "") ?? ""
    }
    
    init?(xml: XMLIndexer) {
        do {
            name = try xml["field"].withAttr("name", "name").element?.text
            if let priceString = try xml["field"].withAttr("name", "price").element?.text,
                let price = Double(priceString) {
                self.price = price
            } else {
                return nil
            }
            symbol = try xml["field"].withAttr("name", "symbol").element?.text
            if let tsString = try xml["field"].withAttr("name", "ts").element?.text,
                let ts = Double(tsString) {
                self.date = Date(timeIntervalSince1970: ts)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}

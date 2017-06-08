//
//  CTCoinMenuItem.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 07/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import AppKit

final class CTCoinMenuItem: NSMenuItem {

    var coin: Coin?
    
    init(coin: Coin, action selector: Selector?, keyEquivalent charCode: String) {
        let title = "\(coin.shortName) - \(coin.price)"
        super.init(title: title, action: selector, keyEquivalent: charCode)
        self.coin = coin
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}

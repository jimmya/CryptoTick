//
//  Array+Extension.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == Double {
    
    func range(withMinOffset minOffset: Double = 0) -> ClosedRange<Double>? {
        guard let min = self.min(),
            let max = self.max() else {
                return nil
        }
        let absoluteRange = max - min
        let adjustedMin = Swift.max(min - (minOffset * absoluteRange), 0)
        let adjustedMax = max + (minOffset * absoluteRange)
        return adjustedMin...adjustedMax
    }
}

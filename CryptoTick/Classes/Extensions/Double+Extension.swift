//
//  Double+Extension.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation

extension Double {
    
    func maxHeight(inRange range: ClosedRange<Double>, withConstraintHeight constraintHeight: CGFloat) -> CGFloat {
        let size = CGFloat(range.upperBound - range.lowerBound)
        let delta = max(0, self - range.lowerBound)
        let height = (CGFloat(delta) / size) * constraintHeight
        return height
    }
}

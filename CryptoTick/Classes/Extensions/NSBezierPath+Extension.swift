//
//  NSBezierPath+Extension.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import AppKit

extension NSBezierPath {
    
    func drawLine(forPoints points: [Double], inRect rect: NSRect, range: ClosedRange<Double>) {
        let itemWidth = rect.width / CGFloat(points.count - 1)
        points.enumerated().forEach { (index, point) in
            let pointHeight = point.maxHeight(inRange: range, withConstraintHeight: rect.height)
            let point = NSPoint(x: CGFloat(index) * itemWidth, y: pointHeight)
            line(to: point)
        }
    }
}

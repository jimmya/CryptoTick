//
//  CTGraphView.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 01/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import Foundation
import AppKit
import RxSwift

final class CTGraphView: NSView {
    
    var priceGraph: [DataPoint] = [] {
        didSet {
            setNeedsDisplay(frame)
        }
    }
    private let disposeBag = DisposeBag()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let prices: [Double] = Array(priceGraph.flatMap({ (dataPoint) -> Double? in
            return dataPoint.value
        }).suffix(244))
        let itemWidth = CGFloat(dirtyRect.width) / CGFloat(prices.count)
        
        guard let minPrice = prices.min(),
            let maxPrice = prices.max() else {
                return
        }
        let absoluteRange = maxPrice - minPrice
        let adjustedMin = max(minPrice - (0.1 * absoluteRange), 0)
        let adjustedMax = maxPrice + (0.1 * absoluteRange)
    
        let range = adjustedMax - adjustedMin
        
        let path: NSBezierPath = NSBezierPath()
        path.move(to: NSPoint())
        
        prices.enumerated().forEach { (index, price) in
            let delta = CGFloat(price - adjustedMin)
            let height = (delta / CGFloat(range)) * dirtyRect.height
            path.line(to: NSPoint(x: CGFloat(index) * itemWidth, y: height))
        }
        
        path.line(to: NSPoint(x: dirtyRect.width, y: 0))
        path.fill()
    }
}

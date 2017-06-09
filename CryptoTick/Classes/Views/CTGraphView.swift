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
        guard let range = prices.range(withMinOffset: 0.1) else {
            return
        }
        
        let path: NSBezierPath = NSBezierPath()
        path.move(to: NSPoint())
        path.drawLine(forPoints: prices, inRect: dirtyRect, range: range)
        path.line(to: NSPoint(x: dirtyRect.width, y: 0))
        path.fill()
    }
}

//
//  NSBezierPathExtensionTests.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import XCTest
@testable import CryptoTick

class NSBezierPathExtensionTests: XCTestCase {
    
    func testBezierPathDrawLine() {
        // Given
        let expectedPoints: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 50, y: 25), CGPoint(x: 100, y: 50), CGPoint(x: 150, y: 75), CGPoint(x: 200, y: 100)]
        let bezierPath = NSBezierPath()
        let points: [Double] = [0, 5, 10, 15, 20]
        let rect = NSRect(x: 0, y: 0, width: 200, height: 100)
        let range = points.range()
        
        // When
        bezierPath.move(to: CGPoint.zero)
        bezierPath.drawLine(forPoints: points, inRect: rect, range: range!)
        
        // Then
        expectedPoints.forEach { (point) in
            XCTAssertTrue(bezierPath.contains(point))
        }
    }
    
    func testBezierPathDrawLineWithOffset() {
        // Given
        let expectedPoints: [CGPoint] = [CGPoint(x: 0, y: 10), CGPoint(x: 50, y: 35), CGPoint(x: 100, y: 60), CGPoint(x: 150, y: 85), CGPoint(x: 200, y: 110)]
        let bezierPath = NSBezierPath()
        let points: [Double] = [5, 10, 15, 20, 25]
        let rect = NSRect(x: 0, y: 0, width: 200, height: 120)
        let range = points.range(withMinOffset: 0.1)
        
        // When
        bezierPath.move(to: CGPoint.zero)
        bezierPath.drawLine(forPoints: points, inRect: rect, range: range!)
        
        // Then
        expectedPoints.forEach { (point) in
            XCTAssertTrue(bezierPath.contains(point))
        }
    }
    
}


//
//  ArrayExtensionTests.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import XCTest
@testable import CryptoTick

class ArrayExtensionTests: XCTestCase {
    
    func testDefaultRange() {
        let points: [Double] = [10, 15, 30, 100]
        let range = points.range()
        XCTAssertEqual(range?.lowerBound, 10)
        XCTAssertEqual(range?.upperBound, 100)
    }
    
    func testDefaultRangeNegativeValues() {
        let points: [Double] = [-10, 15, 30, 100]
        let range = points.range()
        XCTAssertEqual(range?.lowerBound, 0)
        XCTAssertEqual(range?.upperBound, 100)
    }
    
    func testOffsetRange() {
        let points: [Double] = [10, 15, 30, 100]
        let range = points.range(withMinOffset: 0.1)
        XCTAssertEqual(range?.lowerBound, 1)
        XCTAssertEqual(range?.upperBound, 109)
    }
}

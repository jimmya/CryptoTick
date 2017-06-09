//
//  DoubleExtensionTests.swift
//  CryptoTick
//
//  Created by Jimmy Arts on 09/06/2017.
//  Copyright © 2017 Jimmy Arts. All rights reserved.
//

import XCTest
@testable import CryptoTick

class DoubleExtensionTests: XCTestCase {
    
    func testMaxHeight() {
        let point: Double = 10
        let maxHeight = point.maxHeight(inRange: 0...100, withConstraintHeight: 200)
        XCTAssertEqual(maxHeight, 20)
    }
    
    func testMaxHeightOutsideRange() {
        let point: Double = 10
        let maxHeight = point.maxHeight(inRange: 20...100, withConstraintHeight: 200)
        XCTAssertEqual(maxHeight, 0)
    }
}


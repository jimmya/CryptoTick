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
        // Given
        let point: Double = 10
        
        // When
        let maxHeight = point.maxHeight(inRange: 0...100, withConstraintHeight: 200)
        
        // Then
        XCTAssertEqual(maxHeight, 20)
    }
    
    func testMaxHeightOutsideRange() {
        // Given
        let point: Double = 10
        
        // When
        let maxHeight = point.maxHeight(inRange: 20...100, withConstraintHeight: 200)
        
        // Then
        XCTAssertEqual(maxHeight, 0)
    }
}


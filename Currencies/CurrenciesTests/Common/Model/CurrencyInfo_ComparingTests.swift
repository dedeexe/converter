//
//  CurrencyInfo_ComparingTests.swift
//  CurrenciesTests
//
//  Created by Fabricio Santos on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

private class CurrencyInfo_ComparingTests: XCTestCase {
    
    let currency_A = CurrencyInfo(name: "XPT", value: 10.0, multiplier: 1.0)
    let currency_B = CurrencyInfo(name: "XPT", value: 20.0, multiplier: 1.0)
    
    let currency_X = CurrencyInfo(name: "ABC", value: 10.0, multiplier: 1.0)
    let currency_Y = CurrencyInfo(name: "ABC", value: 20.0, multiplier: 1.0)


    func testEqualObjects() {
        
        XCTAssertTrue(currency_A == currency_B, "Equatable comparation fail")
        XCTAssertTrue(currency_X == currency_Y, "Equatable comparation fail")
        XCTAssertFalse(currency_A == currency_X, "Equatable comparation fail")
        XCTAssertFalse(currency_B == currency_Y, "Equatable comparation fail")
    }

    func testDifferentObjects() {
        
        XCTAssertFalse(currency_A != currency_B, "Different comparation fail")
        XCTAssertFalse(currency_X != currency_Y, "Different comparation fail")
        XCTAssertTrue(currency_A != currency_X, "Different comparation fail")
        XCTAssertTrue(currency_B != currency_Y, "Different comparation fail")
        
    }
}

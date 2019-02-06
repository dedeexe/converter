//
//  CurrencyInfoTests.swift
//  CurrenciesTests
//
//  Created by Fabricio Santos on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

fileprivate class CurrencyInfo_ConstructorsTests: XCTestCase {

    var currencyInfo : CurrencyInfo!
    
    let code = "DDS"
    let value = 3.0
    let multiplier = 2.0
    let result = 6.0
    
    override func setUp() {
        currencyInfo = CurrencyInfo(name: code, value: value, multiplier: multiplier)
    }

    func testDefaultObject() {
        checkFieldsOfCurrencyInfo(currencyInfo)
    }

    func testSimpleCopyContructor() {
        let copyCurrency = CurrencyInfo(from: currencyInfo)
        checkFieldsOfCurrencyInfo(copyCurrency)
    }
    
    func testCopyChangingMultiplierConstructor() {
        let copyCurrency = CurrencyInfo(from: currencyInfo, multiplier: multiplier)
        checkFieldsOfCurrencyInfo(copyCurrency)
        
        let newMultiplier = 3.0
        let expectedResult = 9.0
        let copyCurrency2 = CurrencyInfo(from: currencyInfo, multiplier: newMultiplier)
        XCTAssertTrue(copyCurrency2.convertedValue == expectedResult, "ConvertedValue getter value error for changing multiplier constructor")
    }

    func testName_Value_Constructor() {
        let newValue = 10.0
        let expectedResult = 10.0
        let multiplier = 1.0
        let currency = CurrencyInfo(name: code, value: newValue)
        
        XCTAssertTrue(currency.name == code, "Name getter value error")
        XCTAssertTrue(currency.value == newValue, "Value getter value error")
        XCTAssertTrue(currency.multiplier == multiplier, "Multiplier getter value error")
        XCTAssertTrue(currency.convertedValue == expectedResult, "ConvertedValue getter value error")
    }
    
    func testName_Value_Multiplier_Constructor() {
        let currency = CurrencyInfo(name: code, value: value, multiplier: multiplier)
        checkFieldsOfCurrencyInfo(currency)
    }
    
    
    // -------------------------------------------------------
    // MARK: - Helpers
    // -------------------------------------------------------
    
    func checkFieldsOfCurrencyInfo(_ currency:CurrencyInfo) {
        XCTAssertTrue(currency.name == code, "Name getter value error")
        XCTAssertTrue(currency.value == value, "Value getter value error")
        XCTAssertTrue(currency.multiplier == multiplier, "Multiplier getter value error")
        XCTAssertTrue(currency.convertedValue == result, "ConvertedValue getter value error")
    }
    
}

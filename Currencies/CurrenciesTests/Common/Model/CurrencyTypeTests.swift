//
//  CurrencyTypeTests.swift
//  CurrenciesTests
//
//  Created by Fabricio Santos on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

class CurrencyTypeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidImages() {
        let allCases = Currency.allCases
        
        for currency in allCases where currency.image == nil {
            let name = currency.rawValue
            XCTFail("Image Asset not found for \"\(name)\" currency")
        }
    }


}

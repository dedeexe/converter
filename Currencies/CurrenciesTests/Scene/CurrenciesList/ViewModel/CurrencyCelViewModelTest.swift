//
//  CurrencyCelViewModelTest.swift
//  CurrenciesTests
//
//  Created by dede.exe on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

class CurrencyCelViewModelTest: XCTestCase {

    var viewModel       : CurrencyViewViewModel!
    var currency        : CurrencyInfo!
    
    let inputCode   = CurrencyType.CAD.rawValue
    let inputValue  = Double(10.0)
    let inputMult   = Double(1.0)
    
    override func setUp() {
        
        currency        = CurrencyInfo(name: inputCode , value: inputValue, multiplier: inputMult)
        viewModel       = CurrencyViewViewModel(model: currency)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let outputCode   = CurrencyType.CAD
  
        XCTAssertEqual(viewModel.description, outputCode.description, "Wrong description")
        XCTAssertEqual(viewModel.currency, currency, "Wrong currency reference")
        XCTAssertEqual(viewModel.name, outputCode.rawValue, "Wrong name")
    }

}

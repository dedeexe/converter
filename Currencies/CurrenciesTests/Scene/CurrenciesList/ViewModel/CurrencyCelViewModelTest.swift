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
    
    func testValidCurrency() {
        let inputCode   = CurrencyType.CAD.rawValue
        let inputValue  = Double(10.0)
        let inputMult   = Double(1.0)
        let outputCode  = CurrencyType.CAD
  
        let currency    = CurrencyInfo(name: inputCode , value: inputValue, multiplier: inputMult)
        let viewModel   = CurrencyViewViewModel(model: currency)
        
        XCTAssertEqual(viewModel.description, outputCode.description, "Wrong description")
        XCTAssertEqual(viewModel.currency, currency, "Wrong currency reference")
        XCTAssertEqual(viewModel.name, outputCode.rawValue, "Wrong name")
        XCTAssertEqual(viewModel.image, outputCode.image, "Wrong image was returned")
    }

    func testInvalidCurrency() {
        let inputCode   = "XPTO"
        let inputValue  = Double(10.0)
        let inputMult   = Double(1.0)
        let outputCode  = "XPTO"
        let outputDesc  = "unknown"

        let currency    = CurrencyInfo(name: inputCode , value: inputValue, multiplier: inputMult)
        let viewModel   = CurrencyViewViewModel(model: currency)
        
        XCTAssertEqual(viewModel.description.lowercased(), outputDesc, "Wrong description")
        XCTAssertEqual(viewModel.currency, currency, "Wrong currency reference")
        XCTAssertEqual(viewModel.name.lowercased(), outputCode.lowercased(), "Wrong name")
        XCTAssertNil(viewModel.image, "A nil value was expected for this situation")
    }

    
}

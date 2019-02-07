//
//  CurrencyServiceTests.swift
//  CurrenciesTests
//
//  Created by dede.exe on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

class CurrencyService_RequestsTests: XCTestCase {

    var service : CurrencyService?
    
    override func setUp() {
        service = CurrencyService()
    }

    func testSuccessRequest() {
        let currencyType = CurrencyType.EUR
        let expect = XCTestExpectation(description: "Request EUR quotation")
        
        service?.getCurrencies(for: currencyType.rawValue) { result in
            let successCode = 200
            
            switch result {
            case .success(let statusCode, let (returnedCurrency, currencyList)):
                XCTAssertEqual(statusCode, successCode, "Fail - Status code: \(statusCode). Expected \(successCode)")
                XCTAssertEqual(returnedCurrency, CurrencyType.EUR.rawValue, "Fail - The returned Currency \(returnedCurrency) type is different from expected")
                XCTAssertTrue(currencyList.count > 0, "Fail - An empty currency list was returned. Something bigger than 0 was expected")
                
            case .fail(let statusCode, _):
                XCTAssertEqual(statusCode, successCode, "Fail - Status code: \(statusCode). Expected \(successCode)")

            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
        
    }

    func testFailRequest() {
        let currencyType = "XPTO"
        let expect = XCTestExpectation(description: "Request EUR quotation")
        
        service?.getCurrencies(for: currencyType) { result in
            let errorCode = 400
            
            switch result {
            case .success(let statusCode, _):
                XCTAssertFalse(errorCode < 400, "Fail - Success status code: \(statusCode). Expected something bigger than \(errorCode)")
                
            case .fail(let statusCode, _):
                XCTAssertTrue(statusCode >= 400, "Fail - Status code: \(statusCode). Expected something bigger than \(errorCode)")
                
            }
            
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
        
    }

    
}

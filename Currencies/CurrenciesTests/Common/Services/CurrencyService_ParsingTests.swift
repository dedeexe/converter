//
//  CurrencyService_ParsingTests.swift
//  CurrenciesTests
//
//  Created by dede.exe on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies


class CurrencyService_ParsingTests: XCTestCase {
    
    var service : CurrencyService!
    
    func testValidContent() {
        
        let inputBaseCurrency       = CurrencyType.BRL.rawValue
        let jsonFilename            = "currencies_response_list.json"
        let expectedBaseCurrency    = CurrencyType.BRL.rawValue
        let expextedListCount       = 32
        
        let webService = WebServiceCurrencyMock.createWithContentFromFile(jsonFilename)
        service = CurrencyService(using: webService)
        
        service.getCurrencies(for: inputBaseCurrency) { (result) in
            switch result {
            case .success(_, let (baseCurrency, currencies)):
                let currenciesCount = currencies.count
                XCTAssertEqual(baseCurrency,    expectedBaseCurrency,   "Wrong base currency (\(baseCurrency)) returned. Expected (\(expectedBaseCurrency))")
                XCTAssertEqual(currenciesCount, expextedListCount,      "Wrong amount of currencies. Expected \(expextedListCount) and received \(currenciesCount) ")
            default:
                XCTFail("Unexpected behaviour")
            }
        }
        
    }

    func testInvalidResponseContent() {
        
        let inputBaseCurrency       = CurrencyType.BRL.rawValue
        let jsonFilename            = "currencies_response_invalid.json"
        let expextedListCount       = 0

        
        let webService = WebServiceCurrencyMock.createWithContentFromFile(jsonFilename)
        service = CurrencyService(using: webService)
        
        service.getCurrencies(for: inputBaseCurrency) { (result) in
            switch result {
            case .success(_, let (_, currencies)):
                let currenciesCount = currencies.count
                XCTAssertEqual(currenciesCount, expextedListCount, "Wrong amount of currencies. Expected \(expextedListCount) and received \(currenciesCount) ")
            default:
                XCTFail("Unexpected behaviour")
            }
        }
        
    }

    func testUnkownResponseContent() {
        
        let inputBaseCurrency       = CurrencyType.BRL.rawValue
        let jsonFilename            = "currencies_response_unkown.json"
        let expextedListCount       = 0
        
        
        let webService = WebServiceCurrencyMock.createWithContentFromFile(jsonFilename)
        service = CurrencyService(using: webService)
        
        service.getCurrencies(for: inputBaseCurrency) { (result) in
            switch result {
            case .success(_, let (_, currencies)):
                let currenciesCount = currencies.count
                XCTAssertEqual(currenciesCount, expextedListCount, "Wrong amount of currencies. Expected \(expextedListCount) and received \(currenciesCount) ")
            default:
                XCTFail("Unexpected behaviour")
            }
        }
        
    }
    
}


fileprivate class WebServiceCurrencyMock : WebService {
    
    private(set) var content : String = ""
    
    override init() {
        super.init()
    }
    
    static func `default`() -> WebServiceCurrencyMock {
        let webservice = WebServiceCurrencyMock()
        webservice.content = ""
        return webservice
    }
    
    static func createWithContentFromFile(_ filename:String) -> WebServiceCurrencyMock {
        let webservice = WebServiceCurrencyMock()
        
        guard let filepath = Bundle(for: self).path(forResource: filename, ofType: nil) else {
            XCTFail("File \"\(filename)\" not found")
            return webservice
        }
        
        guard let content = try? String(contentsOfFile: filepath) else {
            XCTFail("Fail to load content of file \"\(filename)\"")
            return webservice
        }
        
        webservice.content = content
        return webservice
    }
    
    
    @discardableResult public override func request(request : Endpoint, additionalHeaders:[String:String]? = nil, completion:@escaping ResponseHandler) -> URLRequest? {
        completion(RequestResult.success(200, self.content), [:])
        return nil
    }
    
}



//
//  CurrenciesViewController.swift
//  CurrenciesTests
//
//  Created by dede.exe on 06/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import XCTest
@testable import Currencies

class CurrenciesViewControllerTest: XCTestCase {

    var viewController : CurrenciesViewController!
    var interactor : InteractorCurrenciesMock!
    
    override func setUp() {
        super.setUp()
        
        let ui : CurrenciesListUIView = UIView.instantiateFromNib(named: "CurrenciesListUIView")
        interactor = InteractorCurrenciesMock()
        viewController = CurrenciesViewController(view: ui, interactor: interactor)
        
        ui.delegate = viewController
        interactor.delegate = viewController
        
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        RunLoop.current.run(until: Date())
        
        viewController.preloadView()
    }

    func testCurrenciesResponse() {
        XCTAssertEqual(viewController.currencies.count, 5, "Wrong amount of currencies returned from interactor")
        XCTAssertEqual(viewController.currencyInfo.name, CurrencyType.PHP.rawValue, "Wrong base currency present in viewController")
    }
    
}


// ------------------------------------------------------
// MARK: - Helpers
// ------------------------------------------------------

class InteractorCurrenciesMock : CurrenciesInteractor {
    
    override func start() {
        getCurrencies()
    }
    
    override func getCurrencies() {
        let base = CurrencyInfo(from: CurrencyInfo(name: CurrencyType.PHP.rawValue, value: 2.0))
        
        let currencies : [CurrencyInfo] = [
            CurrencyInfo(name: CurrencyType.BRL.rawValue, value: 10.0, multiplier: base.value),
            CurrencyInfo(name: CurrencyType.PLN.rawValue, value: 10.0, multiplier: base.value),
            CurrencyInfo(name: CurrencyType.AUD.rawValue, value: 10.0, multiplier: base.value),
            CurrencyInfo(name: CurrencyType.USD.rawValue, value: 10.0, multiplier: base.value),
            CurrencyInfo(name: CurrencyType.GBP.rawValue, value: 10.0, multiplier: base.value)
        ]
        
        response(currencies: currencies, for: base.name)
    }
    
    override func response(currencies: [CurrencyInfo], for currency: String) {
        guard let currencyType = CurrencyType(rawValue: currency) else {
            XCTFail("Fail to create type for \(currency)")
            return
        }
        
        delegate?.fetch(currencies: currencies, base: currencyType)
    }
    
}

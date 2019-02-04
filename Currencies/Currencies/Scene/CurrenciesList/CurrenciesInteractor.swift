//
//  CurrenciesInteractor.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

class CurrenciesInteractor : CurrenciesInputInteractor {
    
    private var currency : Currency = .EUR
    private var value : Double = 1.0
    
    private let service : CurrencyService
    private var timer : Timer?
    
    weak var delegate : CurrenciesOutputInteractor?
    
    init(service:CurrencyService? = nil) {
        self.service = service ?? CurrencyService()
    }
    
    func start() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.sendRequest()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func update(value: Double, for currency: Currency) {
        self.value = value
        
        if self.currency != currency {
            self.currency = currency
            sendRequest()
            return
        }
    }
    
    func sendRequest() {
        service.getCurrencies { [weak self] result in
            switch result {
            case .success(_, let currencies):
                self?.response(currencies: currencies)
            case .fail(_, let err):
                self?.handle(error: err)
            }
        }
    }
    
    func response(currencies:[CurrencyInfo]) {
        let currenciesList = currencies + [CurrencyInfo(name: currency.rawValue, value: value, isBase: true)]
        delegate?.fetch(currencies: currenciesList.sorted())
    }

    func handle(error:Error) {
        delegate?.handle(error: error)
    }
    
}

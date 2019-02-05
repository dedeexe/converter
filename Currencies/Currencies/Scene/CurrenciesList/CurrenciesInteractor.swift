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
    private var isMonitoring : Bool = false
    private var value : Double = 1.0
    private let service : CurrencyService
    private var timer : Timer?
    
    weak var delegate : CurrenciesOutputInteractor?
    
    private var lastResult : [CurrencyInfo] = []
    
    init(service:CurrencyService? = nil) {
        self.service = service ?? CurrencyService()
    }
    
    func start() {
        guard timer == nil && !isMonitoring else { return }
        isMonitoring = true
        scheduleRequest()
    }
    
    func scheduleRequest() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.getCurrencies()
        }
    }
    
    func stop() {
        isMonitoring = false
        timer?.invalidate()
        timer = nil
    }
    
    func update(value: Double, for currency: Currency) {
        
        stop()
        if self.currency != currency {
            let oldBaseCurrency = self.currency
            let oldBaseValue = self.value
            
            let newCurrencyInfo = createCurrency(type: oldBaseCurrency, value: oldBaseValue)
            let oldBaseCurrencyInfo = createCurrency(type: currency, value: value)
            
            let resultList = replace(in: self.lastResult, oldCurrency: oldBaseCurrencyInfo, forNew: newCurrencyInfo)
            self.lastResult = resultList
            
            self.currency = currency
            self.value = value
            response(currencies: resultList)

            return
        }
        
        self.currency = currency
        self.value = value
        response(currencies: lastResult)
        start()
        
    }
    
    func getCurrencies() {
        guard isMonitoring else { return }
        self.service.set(value: self.value, to: self.currency)
        
        service.getCurrencies { [weak self] result in
            guard let value = self?.isMonitoring, value == true else { return }
            
            switch result {
            case .success(_, let currencies):
                self?.response(currencies: currencies)
            case .fail(_, let err):
                self?.handle(error: err)
            }
        }
    }
    
    func response(currencies:[CurrencyInfo]) {
        let currenciesList = currencies.compactMap { CurrencyInfo(from: $0, multiplier: value) }
        let base = CurrencyInfo(name: currency.rawValue, value: value)
        lastResult = currenciesList
        delegate?.fetch(currencies: currenciesList, base: base)
        start()
    }

    func handle(error:Error) {
        delegate?.handle(error: error)
    }
    
    private func createCurrency(type:Currency, value:Double) -> CurrencyInfo {
        let currency = CurrencyInfo(name: type.rawValue, value: value)
        return currency
    }
    
    private func replace(in currencies:[CurrencyInfo], oldCurrency:CurrencyInfo, forNew currency:CurrencyInfo) -> [CurrencyInfo] {
        let newList = [currency] + currencies.filter { $0 != oldCurrency }
        return newList
    }
    
}

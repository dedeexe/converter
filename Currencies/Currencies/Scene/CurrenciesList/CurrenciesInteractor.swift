//
//  CurrenciesInteractor.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

class CurrenciesInteractor : CurrenciesInputInteractor {
    
    private var currency : CurrencyType = .EUR
    private var isMonitoring : Bool = false
    private let service : CurrencyService
    private var timer : Timer?
    
    weak var delegate : CurrenciesOutputInteractor?
        
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
    
    func update(currency: CurrencyType) {
        self.currency = currency
    }
    
    func getCurrencies() {
        guard isMonitoring else { return }
        
        service.getCurrencies(for: currency) { [weak self] result in
            guard let value = self?.isMonitoring, value == true else { return }
            
            switch result {
            case .success(_, let resultValue):
                let (base, currencies) = resultValue
                self?.response(currencies: currencies, for: base)
            case .fail(_, let err):
                self?.handle(error: err)
            }
        }
    }
    
    func response(currencies:[CurrencyInfo], for currency:CurrencyType) {
        let currenciesList = currencies.compactMap { CurrencyInfo(from: $0) }
        delegate?.fetch(currencies: currenciesList, base: currency)
    }

    func handle(error:Error) {
        delegate?.handle(error: error)
    }
    
    private func createCurrency(type:CurrencyType, value:Double) -> CurrencyInfo {
        let currency = CurrencyInfo(name: type.rawValue, value: value)
        return currency
    }
    
    private func replace(in currencies:[CurrencyInfo], oldCurrency:CurrencyInfo, forNew currency:CurrencyInfo) -> [CurrencyInfo] {
        let newList = [currency] + currencies.filter { $0 != oldCurrency }
        return newList
    }
    
}

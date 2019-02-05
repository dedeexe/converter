//
//  CurrenciesInteractor.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

class CurrenciesInteractor : CurrenciesInputInteractor {
    
    private var currency : Currency = .EUR {
        didSet { service.currency = currency }
    }
    
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
        self.value = value
        
        if self.currency != currency {
            self.currency = currency
            stop()
            getCurrencies()
            start()
            return
        }
        
        let notBaseCurrencies = lastResult.map { CurrencyInfo(from: $0) }
        response(currencies: notBaseCurrencies)
    }
    
    func getCurrencies() {
        guard isMonitoring else { return }
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
        let currenciesList = currencies.compactMap { CurrencyInfo(from: $0, multiplier: value) }
        let base = CurrencyInfo(name: currency.rawValue, value: value)
        delegate?.fetch(currencies: currenciesList, base: base)
    }

    func handle(error:Error) {
        delegate?.handle(error: error)
    }
    
}

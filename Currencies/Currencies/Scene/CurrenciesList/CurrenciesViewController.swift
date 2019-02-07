//
//  ViewController.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

class CurrenciesViewController: BaseViewController<CurrenciesListUIView>, CurrenciesOutputInteractor, CurrenciesListUIViewDelegate {

    private(set) var currencyType : CurrencyType = .EUR
    private(set) var currencyValue : Double = 1.0
    private(set) var interactor : CurrenciesInputInteractor
    private(set) var currencies : [CurrencyInfo] = []
    
    var currencyInfo : CurrencyInfo {
        return CurrencyInfo(name: currencyType.rawValue, value: currencyValue)
    }
    
    override var canBecomeFirstResponder: Bool { return true }
    
    init(view:CurrenciesListUIView, interactor:CurrenciesInputInteractor) {
        self.interactor = interactor
        super.init(contentView: view)
        view.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.stop()
    }

    // --------------------------------------------------------
    // MARK: - Interactor Output
    // --------------------------------------------------------
    func fetch(currencies: [CurrencyInfo], base: CurrencyType) {
        self.currencies = currencies
        let multipliedCurrencies = currencies.compactMap{ CurrencyInfo(from: $0, multiplier: self.currencyValue) }
        self.contentView.update(currencies: multipliedCurrencies, base: self.currencyInfo, activeTextField: false)
    }
    
    func handle(error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    // --------------------------------------------------------
    // MARK: - CurrenciesListUIView Delegate
    // --------------------------------------------------------

    func currencyViewDidBeginEditting(view: CurrencyView) {
        interactor.stop()
    }
    
    func currencyViewEndBeginEditting(view: CurrencyView) {
        interactor.start()
    }
    
    func tableHandler(_ handler: CurrencyTableHandler, didSelect currency: CurrencyInfo) {
        guard let currencyType = CurrencyType(rawValue: currency.name) else { return }
        
        interactor.stop()
        
        let newCurrencyValue = currency.convertedValue
        self.currencyType = currencyType
        self.currencyValue = newCurrencyValue
        
        interactor.update(currency: self.currencyType)
        interactor.start()
    }
    
    func tableHandlerDidEndEditing(_ handler: CurrencyTableHandler) {
        self.becomeFirstResponder()
    }
    
    func currencyView(view: CurrencyView, didUpdate value: String) {
        let format = NumberFormatter()
        format.locale = Locale.current
        format.numberStyle = .decimal
        
        guard let number : NSNumber = format.number(from: value) else { return }
        currencyValue = number.doubleValue
        
        let multipliedCurrencies = currencies.compactMap{ CurrencyInfo(from: $0, multiplier: self.currencyValue) }
        self.contentView.update(currencies: multipliedCurrencies, base: self.currencyInfo, activeTextField: true)
    }
}


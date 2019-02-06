//
//  ViewController.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

class CurrenciesViewController: BaseViewController<CurrenciesListUIView>, CurrenciesOutputInteractor, CurrenciesListUIViewDelegate {

    private(set) var currencyType : Currency = .EUR
    private(set) var interactor : CurrenciesInputInteractor
    private(set) var currencies : [CurrencyInfo] = []
    private(set) var baseValue : Double = 1.0
    
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
    
    func fetch(currencies: [CurrencyInfo], base:CurrencyInfo) {
        self.currencies = currencies
        self.contentView.update(currencies: currencies, base: base, activeTextField: true)
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
        interactor.update(value: baseValue, for: currencyType)
        interactor.start()
    }
    
    func tableHandler(_ handler: CurrencyTableHandler, didSelect currency: CurrencyInfo) {
        guard let currencyType = Currency(rawValue: currency.name) else { return }
        
        let currencyValue = currency.convertedValue
        self.currencyType = currencyType
        self.baseValue = currency.convertedValue
        
        interactor.update(value: currencyValue, for: self.currencyType)
    }
    
    func tableHandlerDidEndEditing(_ handler: CurrencyTableHandler) {
        self.becomeFirstResponder()
    }
    
    func currencyView(view: CurrencyView, didUpdate value: String) {
        let format = NumberFormatter()
        format.locale = Locale.current
        format.numberStyle = .decimal
        
        guard let number : NSNumber = format.number(from: value) else { return }
        baseValue = number.doubleValue
        
        interactor.update(value: baseValue, for: currencyType)
    }
}


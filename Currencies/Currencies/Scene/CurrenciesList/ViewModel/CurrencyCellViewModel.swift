//
//  CurrencyCellViewModel.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

struct CurrencyViewViewModel : CurrencyViewDataSource {
    var name: String { return currency.name }
    
    var description: String {
        guard let type = Currency(rawValue: currency.name) else { return "Unknown" }
        return type.description
    }
    
    var image: UIImage? { return nil }
    
    var value: String {
        let formater = NumberFormatter()
        formater.locale = Locale.current
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: currency.convertedValue)) ?? ""
    }
    
    let currency : CurrencyInfo
    
    init(model : CurrencyInfo) {
        self.currency = model
    }
    
}

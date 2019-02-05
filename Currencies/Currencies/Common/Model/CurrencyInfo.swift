//
//  Currency.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

struct CurrencyInfo {
    
    let value : Double
    let name : String
    let multiplier : Double
    
    init(name:String, value:Double, multiplier:Double = 1.0) {
        self.value = value
        self.name = name
        self.multiplier = multiplier
    }

    init(from currency:CurrencyInfo, multiplier:Double) {
        self.value = currency.value
        self.name = currency.name
        self.multiplier = multiplier
    }

    init(from currency:CurrencyInfo) {
        self.value = currency.value
        self.name = currency.name
        self.multiplier = currency.multiplier
    }
    
    var convertedValue : Double {
        return value * multiplier
    }
    
}

extension CurrencyInfo : Equatable {
    static func == (lhs:CurrencyInfo, rhs:CurrencyInfo) -> Bool {
        return lhs.name == rhs.name
    }
}

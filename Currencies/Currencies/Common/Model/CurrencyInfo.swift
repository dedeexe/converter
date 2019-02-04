//
//  Currency.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

struct CurrencyInfo {
    
    let isBase : Bool
    let value : Double
    let name : String
    let multiplier : Double
    
    init(name:String, value:Double, multiplier:Double = 1.0, isBase:Bool = false) {
        self.isBase = isBase
        self.value = value
        self.name = name
        self.multiplier = multiplier
    }

    init(from currency:CurrencyInfo, multiplier:Double) {
        self.isBase = currency.isBase
        self.value = currency.value
        self.name = currency.name
        self.multiplier = multiplier
    }

    init(from currency:CurrencyInfo) {
        self.isBase = false
        self.value = currency.value
        self.name = currency.name
        self.multiplier = currency.multiplier
    }
    
    var convertedValue : Double {
        if isBase { return value }
        return value * multiplier
    }
    
}

extension CurrencyInfo : Comparable, Hashable {
    static func < (lhs: CurrencyInfo, rhs: CurrencyInfo) -> Bool {
        if rhs.isBase { return false }
        return lhs.isBase || (lhs.name < rhs.name)
    }
    
    static func == (lhs: CurrencyInfo, rhs: CurrencyInfo) -> Bool {
        return lhs.name == rhs.name
    }
    
    var hashValue : Int {
        return self.name.hashValue
    }
}

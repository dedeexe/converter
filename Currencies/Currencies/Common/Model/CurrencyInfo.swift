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
    let name : String
    let value : Double
    let multiplier : Double
    
    init(name:String, value:Double, multiplier:Double = 1.0, isBase:Bool = false) {
        self.isBase = isBase
        self.value = value
        self.name = name
        self.multiplier = multiplier
    }
    
    var convertedValue : Double {
        if isBase { return value }
        return value * multiplier
    }
    
}

extension CurrencyInfo : Comparable {
    static func < (lhs: CurrencyInfo, rhs: CurrencyInfo) -> Bool {
        if lhs.isBase == true {
            return true
        }
        
        return lhs.name < rhs.name
    }
    
    static func == (lhs: CurrencyInfo, rhs: CurrencyInfo) -> Bool {
        return lhs.name == rhs.name
    }
    
}

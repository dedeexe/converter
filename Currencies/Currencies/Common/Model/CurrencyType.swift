//
//  CurrencyType.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

enum CurrencyType : String, CaseIterable {
    
    case AUD
    case BGN, BRL
    case CAD, CHF, CNY, CZK
    case DKK
    case EUR
    case GBP
    case HKD, HRK, HUF
    case IDR, ILS, INR, ISK
    case JPY
    case KRW
    case MXN, MYR
    case NOK, NZD
    case PHP, PLN
    case RON, RUB
    case SEK, SGD
    case THB, TRY
    case USD
    case ZAR
    
    var description : String {
        let values : [CurrencyType : String] = [
            CurrencyType.AUD : "Australian Dollar",
            CurrencyType.BGN : "Bulgarian lev",
            CurrencyType.BRL : "Brazilian real",
            CurrencyType.CAD : "Canadian dollar",
            CurrencyType.CHF : "Swiss franc",
            CurrencyType.CNY : "Chinese yuan",
            CurrencyType.CZK : "Czech koruna",
            CurrencyType.DKK : "Danish krone",
            CurrencyType.EUR : "Euro",
            CurrencyType.GBP : "British pound",
            CurrencyType.HKD : "Hong Kong dollar",
            CurrencyType.HRK : "Croatian kuna",
            CurrencyType.HUF : "Hungarian forint",
            CurrencyType.IDR : "Indonesian rupiah",
            CurrencyType.ILS : "Israeli new shekel",
            CurrencyType.INR : "Indian rupee",
            CurrencyType.ISK : "Icelandic króna",
            CurrencyType.JPY : "Japanese yen",
            CurrencyType.KRW : "South Korean won",
            CurrencyType.MXN : "Mexican peso",
            CurrencyType.MYR : "Malaysian ringgit",
            CurrencyType.NOK : "Norwegian krone",
            CurrencyType.NZD : "New Zealand dollar",
            CurrencyType.PHP : "Philippine peso",
            CurrencyType.PLN : "Polish złoty",
            CurrencyType.RON : "Romanian leu",
            CurrencyType.RUB : "Russian ruble",
            CurrencyType.SEK : "Swedish krona",
            CurrencyType.SGD : "Singapore dollar",
            CurrencyType.THB : "Thai baht",
            CurrencyType.TRY : "Turkish lira",
            CurrencyType.USD : "United States dollar",
            CurrencyType.ZAR : "South African rand",
        ]
        
        return values[self] ?? "Unknown"
    }
    
    var image : UIImage? {
        let imageName = self.rawValue.uppercased()
        let name = String(imageName)
        return UIImage(named:name)
    }
}

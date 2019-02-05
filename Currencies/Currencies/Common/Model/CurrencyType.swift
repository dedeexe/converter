//
//  CurrencyType.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

enum Currency : String, CaseIterable {
    
    case AUD
    case BGN, BRL, CAD
    case CHF, CNY, CZK
    case DKK
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
    case EUR
    
    var description : String {
        let values : [Currency : String] = [
            Currency.AUD : "Australian Dollar",
            Currency.BGN : "Bulgarian lev",
            Currency.BRL : "Brazilian real",
            Currency.CAD : "Canadian dollar",
            Currency.CHF : "Swiss franc",
            Currency.CNY : "Chinese yuan",
            Currency.CZK : "Czech koruna",
            Currency.DKK : "Danish krone",
            Currency.GBP : "British pound",
            Currency.HKD : "Hong Kong dollar",
            Currency.HRK : "Croatian kuna",
            Currency.HUF : "Hungarian forint",
            Currency.IDR : "Indonesian rupiah",
            Currency.ILS : "Israeli new shekel",
            Currency.INR : "Indian rupee",
            Currency.ISK : "Icelandic króna",
            Currency.JPY : "Japanese yen",
            Currency.KRW : "South Korean won",
            Currency.MXN : "Mexican peso",
            Currency.MYR : "Malaysian ringgit",
            Currency.NOK : "Norwegian krone",
            Currency.NZD : "New Zealand dollar",
            Currency.PHP : "Philippine peso",
            Currency.PLN : "Polish złoty",
            Currency.RON : "Romanian leu",
            Currency.RUB : "Russian ruble",
            Currency.SEK : "Swedish krona",
            Currency.SGD : "Singapore dollar",
            Currency.THB : "Thai baht",
            Currency.TRY : "Turkish lira",
            Currency.USD : "United States dollar",
            Currency.ZAR : "South African rand",
        ]
        
        return values[self] ?? "Unknown"
    }
    
    var image : UIImage? {
        let imageName = self.rawValue.lowercased()
        let startIndex = imageName.startIndex
        let endIndex = imageName.index(startIndex, offsetBy: 2)
        let name = String(imageName[startIndex..<endIndex])
        return UIImage(named:name)
    }
}

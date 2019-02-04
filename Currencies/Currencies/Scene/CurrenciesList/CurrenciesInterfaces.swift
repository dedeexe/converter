//
//  CurrenciesInterfaces.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

protocol CurrenciesInputInteractor : class {
    func start()
    func stop()
}

protocol CurrenciesOutputInteractor : class {
    func fetch()
}

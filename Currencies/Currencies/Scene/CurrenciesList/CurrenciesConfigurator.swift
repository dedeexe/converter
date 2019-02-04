//
//  CurrenciesConfigurator.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

final class CurrenciesConfigurator {
    
    static func create() -> CurrenciesViewController {
        let ui = CurrenciesListUIView()
        let interactor = CurrenciesInteractor()
        let controller = CurrenciesViewController(view: ui, interactor: interactor)
        
        interactor.delegate = controller
        
        return controller
    }
    
}

//
//  ViewController.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

class CurrenciesViewController: BaseViewController<CurrenciesListUIView> {
    
    private(set) var interactor : CurrenciesInputInteractor
    
    init(view:CurrenciesListUIView, interactor:CurrenciesInputInteractor) {
        self.interactor = interactor
        super.init(contentView: view)
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

}

extension CurrenciesViewController : CurrenciesOutputInteractor {
    func fetch(currencies: [CurrencyInfo]) {
        
    }
    
    func handle(error: Error) {
        
    }
}

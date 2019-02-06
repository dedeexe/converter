//
//  CurrenciesListView.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

protocol CurrenciesListUIViewDelegate : CurrencyTableHandlerDelegate {}

class CurrenciesListUIView : UIView {
    
    private(set) var tableHandler : CurrencyTableHandler?
    @IBOutlet weak var tableView : UITableView!
    
    weak var delegate : CurrenciesListUIViewDelegate? {
        didSet { tableHandler?.delegate = self.delegate }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        build()
    }
    
    func build() {
        tableHandler = CurrencyTableHandler(tableView: tableView)
    }
    
    func update(currencies:[CurrencyInfo], base:CurrencyInfo, activeTextField:Bool) {
        DispatchQueue.main.async { [weak self] in
            if !activeTextField {
                self?.tableHandler?.update(base: base, currencies: currencies)
                return
            }
            
            self?.tableHandler?.updateValues(currencies: currencies)
        }
    }
    
}

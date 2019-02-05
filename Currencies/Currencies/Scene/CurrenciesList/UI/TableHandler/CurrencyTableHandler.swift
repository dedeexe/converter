//
//  CurrencyTableHandler.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

protocol CurrencyTableHandlerDelegate : CurrencyCellDelegate {
    func tableHandler(_ handler:CurrencyTableHandler, didSelect currency:CurrencyInfo)
}

class CurrencyTableHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private enum Sections : Int {
        case base = 0
        case currencies
        case total
    }

    unowned let tableView : UITableView
    weak var delegate : CurrencyTableHandlerDelegate?
    private var currencies: [CurrencyInfo] = []
    private var baseCurrency : CurrencyInfo? = nil
    
    func update(base:CurrencyInfo, currencies:[CurrencyInfo]) {
        self.currencies = currencies
        self.baseCurrency = base
        self.tableView.reloadData()
    }
    
    init(tableView : UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.registerReusableCell(CurrencyCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }
    
    //MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case Sections.currencies.rawValue = section {
            return currencies.count
        }
        
        return (baseCurrency != nil) ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyCell.reuseIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CurrencyCell else {
            fatalError("Not found \(identifier) cell.")
        }
        
        cell.delegate = self.delegate
        
        if case Sections.base.rawValue = indexPath.section, let base = baseCurrency {
            cell.update(currency: base)
        } else if case Sections.currencies.rawValue = indexPath.section {
            cell.update(currency: currencies[indexPath.row])
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = currencies[indexPath.row]
        delegate?.tableHandler(self, didSelect: selectedCurrency)
    }
    
}

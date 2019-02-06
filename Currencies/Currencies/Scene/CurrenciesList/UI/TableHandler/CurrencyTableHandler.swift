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
    func tableHandlerDidEndEditing(_ handler:CurrencyTableHandler)
}

class CurrencyTableHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private enum Sections : Int {
        case base = 0
        case currencies
        case total
    }

    private var firstCellSelected : Bool = false
    unowned let tableView : UITableView
    weak var delegate : CurrencyTableHandlerDelegate?
    private var currencies: [CurrencyInfo] = []
    private var baseCurrency : CurrencyInfo? = nil
    
    func update(base:CurrencyInfo, currencies:[CurrencyInfo]) {
        self.currencies = currencies
        self.baseCurrency = base
        self.tableView.reloadData()
    }

    func updateValues(currencies:[CurrencyInfo]) {
        self.currencies = currencies
        
        let visibleCells = tableView.visibleCells
        
        for cell in visibleCells {
            if let indexPath = tableView.indexPath(for: cell),
                let currencyCell = cell as? CurrencyCell,
                indexPath.section != Sections.base.rawValue
            {
                decorateCell(cell: currencyCell, at: indexPath)
            }
        }
    }
    
    init(tableView : UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.registerReusableCell(CurrencyCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }
    
    // --------------------------------------------------------
    // MARK: - Helper
    // --------------------------------------------------------
    
    private func decorateCell(cell:UITableViewCell, at indexPath:IndexPath) {
        let currency = currencies[indexPath.row]
        (cell as? CurrencyCell)?.update(currency: currency)
    }
    
    private func replaceBase(for currency:CurrencyInfo, at indexPath:IndexPath) {
        guard let oldBaseCurrency = self.baseCurrency else { return }
        var currencies = self.currencies
        
        currencies.remove(at: indexPath.row)
        
        self.baseCurrency = currency
        self.currencies = [oldBaseCurrency] + currencies
        
        let baseIndexPath = IndexPath(row: 0, section: Sections.base.rawValue)
        let firstCurrencyIndexPath = IndexPath(row: 0, section: Sections.currencies.rawValue)
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath, baseIndexPath, firstCurrencyIndexPath], with: .top)
        tableView.endUpdates()
    }
    
    // --------------------------------------------------------
    // MARK: - TableView DataSource
    // --------------------------------------------------------
    
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
            cell.enableText(true)
        } else if case Sections.currencies.rawValue = indexPath.section {
            decorateCell(cell: cell, at: indexPath)
            cell.enableText(false)
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // --------------------------------------------------------
    // MARK: - TableView Delegate
    // --------------------------------------------------------

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case Sections.currencies.rawValue = indexPath.section else { return }
        
        let selectedCurrency = currencies[indexPath.row]
        replaceBase(for: selectedCurrency, at: indexPath)
        delegate?.tableHandler(self, didSelect: selectedCurrency)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        firstCellSelected = false
        delegate?.tableHandlerDidEndEditing(self)
    }
    
}

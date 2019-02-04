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
    
    weak var delegate : CurrencyTableHandlerDelegate?
    unowned let tableView : UITableView
    
    var currencies: [CurrencyInfo] = [] {
        didSet { update() }
    }
    
    init(tableView : UITableView) {
        self.tableView = tableView
        super.init()
        self.register()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func update() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func register() {
        tableView.registerReusableCell(CurrencyCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyCell.reuseIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CurrencyCell else {
            fatalError("Not found \(identifier) cell.")
        }
        
        cell.delegate = self.delegate
        cell.update(currency: currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableHandler(self, didSelect: currencies[indexPath.row])
    }

}

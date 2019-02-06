//
//  CurrencyCell.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

protocol CurrencyCellDelegate : CurrencyViewDelegate {}

class CurrencyCell: UITableViewCell, ReusableCell {
    
    weak var delegate : CurrencyViewDelegate? {
        didSet { currencyView.delegate = delegate }
    }
    
    private var currencyView : CurrencyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        build()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        build()
    }
    
    func responderInTextField() {
        currencyView.responderInTextField()
    }
    
    func build() {
        currencyView = UIView.instantiateFromNib(named: "CurrencyView")
        currencyView.delegate = self.delegate
        contentView.addSubview(currencyView)
        
        currencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        currencyView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        currencyView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        currencyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func update(currency:CurrencyInfo) {
        let model = CurrencyViewViewModel(model: currency)
        currencyView.update(dataSource: model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            responderInTextField()
        }
    }

}

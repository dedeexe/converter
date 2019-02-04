//
//  CurrencyView.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

protocol CurrencyViewDelegate : class {
    func currencyView(view:CurrencyView, didUpdate value:String)
}

protocol CurrencyViewDataSource {
    var name : String { get }
    var description : String { get }
    var image : UIImage? { get }
    var value : String { get }
}

class CurrencyView: UIView {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var countryImageView : UIImageView!
    @IBOutlet weak var valueTextField : UITextField!
    
    weak var delegate : CurrencyViewDelegate?    
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        valueTextField.keyboardType = .decimalPad
        countryImageView.layer.cornerRadius = countryImageView.frame.width / 2
        countryImageView.layer.masksToBounds = true
    }
    
    func update(dataSource: CurrencyViewDataSource) {
        nameLabel.text = dataSource.name
        descriptionLabel.text = dataSource.description
        countryImageView.image = dataSource.image
        valueTextField.text = dataSource.value
    }
    
    func reset() {
        nameLabel.text = nil
        descriptionLabel.text = nil
        countryImageView.image = nil
        valueTextField.text = nil
    }
    
}

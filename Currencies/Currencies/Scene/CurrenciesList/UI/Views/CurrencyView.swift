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
    func currencyViewDidBeginEditting(view:CurrencyView)
    func currencyViewEndBeginEditting(view:CurrencyView)
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
    @IBOutlet weak var markerView : UIView!
    
    let selectedColor       = UIColor.blue
    let deselectedColor     = UIColor.lightGray
    
    weak var delegate : CurrencyViewDelegate?    
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        valueTextField.textAlignment = .right
        valueTextField.keyboardType = .decimalPad
        valueTextField.delegate = self
        
        countryImageView.layer.cornerRadius = countryImageView.frame.width / 2
        countryImageView.layer.masksToBounds = true
        
        valueTextField.addTarget(self, action: #selector(textFieldDidchange), for: .valueChanged)
        markerView.backgroundColor = deselectedColor
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
    
    @objc func textFieldDidchange(sender:UITextField) {
        sender.invalidateIntrinsicContentSize()
    }
    
}

extension CurrencyView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        delegate?.currencyView(view: self, didUpdate: newString)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        markerView.backgroundColor = selectedColor
        delegate?.currencyViewDidBeginEditting(view: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        markerView.backgroundColor = deselectedColor
        delegate?.currencyViewEndBeginEditting(view: self)
    }
}

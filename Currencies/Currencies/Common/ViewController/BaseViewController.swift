//
//  BaseViewController.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

class BaseViewController<VIEW:UIView> : UIViewController {
    
    var contentView : VIEW
    
    init(contentView:VIEW) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

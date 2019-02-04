//
//  CurrencyService.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

struct CurrencyServiceEndpoint : Endpoint {
    
    let base : String
    
    var baseURL: String { return AppConfig.baseURL }
    var path: String { return "latest" }
    var method: RequestMethod = .get
    var parameters: [String : Any] { return ["base" : self.base] }
    
    var headers: [String : String] = [:]
    
    init(base:Currency) {
        self.base = base.rawValue
    }
    
}

class CurrencyService {
    
    var currency : Currency
    private var endpoint : CurrencyServiceEndpoint
    
    init() {
        currency = .EUR
        endpoint = CurrencyServiceEndpoint(base: currency)
    }
    
    func getCurrencies() {
        
        WebService.instance.request(request: endpoint) { (result, _ ) in
            
            switch result {
            case .success(_, let values):
                print(values)
                
            case .fail(_, let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
    
}

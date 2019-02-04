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
    
    func getCurrencies(then completion: @escaping (RequestResult<[CurrencyInfo]>) -> Void) {
        
        WebService.instance.request(request: endpoint) { [weak self] (result, _ ) in
            
            switch result {
            case .success(let statusCode, let values):
                let convertedResult = self?.convertCurrency(jsonString: values) ?? []
                completion(RequestResult<[CurrencyInfo]>.success(statusCode, convertedResult))
                
            case .fail(let statusCode, let err):
                completion(RequestResult<[CurrencyInfo]>.fail(statusCode, err))
            }
            
        }
        
    }
    
    private func convertCurrency(jsonString:String?) -> [CurrencyInfo] {
        guard let data = jsonString?.data(using: .utf8) else { return [] }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] else { return [] }
        
        let rates = (json?["rates"] as? [String:Double]) ?? [:]
        let currencies = rates.compactMap {
            CurrencyInfo(name: $0.key, value: $0.value)
        }
        
        return currencies
    }
    
}

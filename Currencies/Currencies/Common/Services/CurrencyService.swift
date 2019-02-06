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
    
    init(base:CurrencyType) {
        self.base = base.rawValue
    }
    
}

class CurrencyService {
    
    typealias ResultType = (CurrencyType, [CurrencyInfo])
    
    func getCurrencies(for currency:CurrencyType, then completion: @escaping (RequestResult<ResultType>) -> Void) {
        
        let endpoint = CurrencyServiceEndpoint(base: currency)
        
        WebService.instance.request(request: endpoint) { [weak self] (result, _ ) in
            
            switch result {
            case .success(let statusCode, let values):
                let convertedResult = self?.convertCurrency(jsonString: values) ?? []
                let result : ResultType = (currency, convertedResult)
                completion(RequestResult<ResultType>.success(statusCode, result))
                
            case .fail(let statusCode, let err):
                completion(RequestResult<ResultType>.fail(statusCode, err))
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

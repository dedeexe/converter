//
//  Dictionary+Encoder.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

extension Dictionary {
    func urlQuery(encoded:Bool = true) -> String {
        var itens : [String] = []
        
        for (key, value) in self {
            var encodedValue = "\(value)"
            var encodedKey = "\(key)"
            
            if encoded {
                encodedValue = encodedValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
                encodedKey = encodedKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            }
            
            itens.append("\(encodedKey)=\(encodedValue)")
        }
        
        let result = itens.joined(separator: "&")
        return result
    }
}

//
//  Serializable.swift
//  Currencies
//
//  Created by Fabricio Santos on 04/02/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

protocol Serializable : Codable {
    func serialize() -> String?
}

extension Serializable {
    
    func serialize() -> String? {
        let encoder = JSONEncoder()
        
        guard let encodedData = try? encoder.encode(self), let encodedString = String(data: encodedData, encoding: .utf8) else {
            return nil
        }
        
        return encodedString
    }
    
}

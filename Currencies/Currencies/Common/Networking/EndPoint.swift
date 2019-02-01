//
//  EndPoint.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL     : String { get }
    var path        : String { get }
    var fullPath    : String { get }
    var encoding    : RequestEncoding { get }
    var method      : RequestMethod { get }
    var parameters  : [String:Any] { get }
    var body        : Data? { get }
    var headers     : [String:String] { get }
}

extension Endpoint {
    
    public var fullPath : String {
        
        if encoding == .url {
            let params = parameters.urlQuery(encoded: true)
            if params.count > 0 {
                return baseURL + path + "?" + params
            }
        }
        
        return baseURL + path
    }
    
    public var encoding : RequestEncoding {
        if method == RequestMethod.get {
            return RequestEncoding.url
        }
        
        return RequestEncoding.json
    }
    
    public var body : Data? {
        
        if encoding == .url {
            return parameters.urlQuery(encoded: true).data(using: .utf8)
        }
        
        if encoding == .httpBody {
            return parameters.urlQuery(encoded: false).data(using: .utf8)
        }
        
        guard parameters.keys.count > 0 else {
            return nil
        }
        
        let json = try? JSONSerialization.data(withJSONObject: parameters, options: .init(rawValue: 0))
        let jsonString = String(data:json ?? Data(), encoding:.utf8)
        return jsonString?.data(using: .utf8)
    }
    
}

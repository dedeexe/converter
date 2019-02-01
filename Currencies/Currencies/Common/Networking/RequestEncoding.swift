//
//  RequestEncoding.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

public enum RequestEncoding : String {
    case url
    case json
    case httpBody
}

extension RequestEncoding {
    var contentType : String {
        switch self {
        case .json              : return "application/json"
        case .url, .httpBody    : return ""
        }
    }
}

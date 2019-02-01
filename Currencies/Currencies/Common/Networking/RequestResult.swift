//
//  RequestResult.swift
//  Currencies
//
//  Created by dede.exe on 31/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

public enum RequestResult<T> {
    case success(Int, T)
    case fail(Int, Error)
}

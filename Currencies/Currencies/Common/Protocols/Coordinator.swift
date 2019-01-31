//
//  Coordinator.swift
//  Currencies
//
//  Created by dede.exe on 30/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import Foundation

protocol Coordinator : class {
    
    var children : [Coordinator] { get set }
    func start()
    
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func removeChild(coordinator: Coordinator) {
        children = children.filter { $0 !== coordinator }
    }
}

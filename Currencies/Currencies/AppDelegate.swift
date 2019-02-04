//
//  AppDelegate.swift
//  Currencies
//
//  Created by Fabricio Santos on 29/01/19.
//  Copyright © 2019 dede.exe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createInitialScreen()
        return true
    }

    private func createInitialScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller = CurrenciesConfigurator.create()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }


}


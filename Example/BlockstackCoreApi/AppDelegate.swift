//
//  AppDelegate.swift
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//

import UIKit
import BlockstackCoreApi

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme.contains("bs")
        {
            return BSBrowserAuth.application(app, open: url, options: options)
        }
        return false
    }
    
    func topViewController() -> UIViewController?
    {
        if let nav = window?.rootViewController as? UINavigationController
        {
            return nav.topViewController
        }
        return nil
    }

}


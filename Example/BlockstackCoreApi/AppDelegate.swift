//
//  AppDelegate.swift
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme.contains("bs"), let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        {
            let token = queryItems.filter({ $0.name == "token"}).first?.value
            
            if let topVC = topViewController()
            {
                if let token = token
                {
                    let alert = UIAlertController(title: "Authorization Successful", message: "Blockstack access granted\n\(token)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        
                    }))
                    topVC.present(alert, animated: true, completion: nil)
                    return true
                }
                else{
                    let alert = UIAlertController(title: "Authorization Denied", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        
                    }))
                    topVC.present(alert, animated: true, completion: nil)
                    return true
                }
            }
            
        }
        return false
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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


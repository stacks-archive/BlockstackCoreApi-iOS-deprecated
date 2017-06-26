//
//  BSBrowserAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//

import UIKit

public class BSBrowserAuth: NSObject {
    
    static var responseHandler : ((String?) -> Void)?
    
    
    public static func authorize(appId: String, name: String, handler : @escaping (String?) -> Void)
    {
        let url = URL(string: "blockstack://auth?id=\(appId)&name=\(name)")!
        UIApplication.shared.openURL(url)
        responseHandler = handler
    }
    
    public static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let scheme = url.scheme, scheme.contains("bs")
        {
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
            let token = queryItems?.filter({ $0.name == "token"}).first?.value
            if let handler = responseHandler
            {
                handler(token)
            }
            return true
        }
        return false
    }
}

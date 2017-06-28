//
//  BSBrowserAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  This class is called by a 3rd party application to check to authorize the app with blockstack.

import UIKit

public class BSBrowserAuth: NSObject {
    
    static var responseHandler : ((String?) -> Void)?
    
    //determine if we can authorize the app, which will tell us if blockstack is installed.
    public static func canAuthorize() -> Bool
    {
        let url = URL(string: "blockstack://")!
        return UIApplication.shared.canOpenURL(url)
    }
    
    //call blockstack to authorize and then call the completion handler with the resulting token
    //it will retain the completion handler to be called after authorizatin and open the block stack app
    public static func authorize(appId: String, name: String, handler : @escaping (String?) -> Void)
    {
        let urlString = "blockstack://auth?id=\(appId)&name=\(name)"
        
        guard canAuthorize() == true else {
            handler(nil)
            return
        }
        
        guard let encodedString = String(format: urlString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: encodedString) else {
            handler(nil)
            return
        }
        
        UIApplication.shared.openURL(url)
        responseHandler = handler
    }
    
    //this method must be called by the authorization seeking app on open URL. It will parse the token from the url
    //and call the previously set completion handler
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

//
//  BSBrowserAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//

import UIKit

public class BSBrowserAuth: NSObject {
    public static func authorize(appId: String, name: String)
    {
        let url = URL(string: "blockstack://auth?id=\(appId)&name=\(name)")!
        UIApplication.shared.openURL(url)
    }
}

//
//  ViewController.swift
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//

import UIKit
import BlockstackCoreApi

class MainViewController: UIViewController {
    
    @IBAction func authorize()
    {
        //verify blockstack is installed.
        guard (BrowserAuth.canAuthorize() == true) else
        {
            return
        }
        
        //perform an authorization with a random ID and the app name.
        //alert the user of the result
        BrowserAuth.authorize(appId: "777", name: "HelloBlockStack") { (token) in
                if let token = token
                {
                    let alert = UIAlertController(title: "Authorization Successful", message: "Blockstack access granted with Token:\n\(token)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "Authorization Denied", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
}


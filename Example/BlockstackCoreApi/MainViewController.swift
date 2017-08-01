//
//  ViewController.swift
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//

import UIKit
import BlockstackCoreApi_iOS

class MainViewController: UIViewController {
    
    @IBAction func authorize()
    {
        //verify blockstack is installed.
        guard (BrowserAuth.canAuthorize() == true) else
        {
            let alert = UIAlertController(title: "Blockstack Not Installed", message: "You must install the Blockstack Browser App in order to get authorization.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //set our manifest values
        BrowserAuth.manifest.name = "Blockstack Core Api"
        BrowserAuth.manifest.shortName = "Core"
        
        //perform an authorization with a random ID and the app name.
        //alert the user of the result
        BrowserAuth.authorize() { (response) in
                if let response = response
                {
                    var userDescription = ""
                    if let name = response.username
                    {
                        userDescription = name
                    }
                    else if let name = response.profile.givenName
                    {
                        userDescription = name
                    }
                    else if let address = response.profile.account.first?.identifier, let service = response.profile.account.first?.service
                    {
                        userDescription = "\(service): \(address)"
                    }else{
                        userDescription = response.authResponseToken
                    }
                    
                    let alert = UIAlertController(title: "Authorization Successful", message: "Blockstack access granted:\n\(userDescription)", preferredStyle: .alert)
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


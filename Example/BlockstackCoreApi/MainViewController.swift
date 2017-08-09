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
    
    @IBOutlet var titleLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDisplayLabel()
        
        let token = ["iat" : NSNumber(value: 1440713414.85)]
        let privateKey = "278a5de700e29faae8e40e366ec5012b5ec63d36ec77e8a2417154cc1d25383f"
        let publicKey = "03fdd57adec3d438ea237fe46b33ee1e016eda6b585c3e27ea66686c2ea5358479"
        let signed = TokenSigner.shared().sign(tokenPayload: token, privateKey: privateKey)!
        print("Signed : " + signed)
        
        let decoded = TokenSigner.shared().decodeToken(signed) as! [String : Any]
        print("decoded : \(decoded)")
        
        let unsecured = TokenSigner.shared().createUnsecuredToken(tokenPayload: token)!
        print("unsecured token : \(unsecured)")
        
        let verified = TokenSigner.shared().verify(token: signed, publicKey: publicKey)
        print("verified : \(verified)")
    }
    
    func setDisplayLabel()
    {
        if let currentUserName = BlockstackAuth.currentUserProfile()?.name ?? BlockstackAuth.currentUserProfile()?.givenName
        {
            titleLabel.text = "Logged in as: \(currentUserName)"
        }
    }
    
    @IBAction func authorize()
    {
        //verify blockstack is installed.
        guard (BlockstackAuth.canAuthorize() == true) else
        {
            let alert = UIAlertController(title: "Blockstack Not Installed", message: "You must install the Blockstack Browser App in order to get authorization.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //set our manifest values
        BlockstackAuth.manifest.name = "Blockstack Core Api"
        BlockstackAuth.manifest.shortName = "Core"
        
        //perform an authorization with a random ID and the app name.
        //alert the user of the result
        BlockstackAuth.authorize() { (response) in
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
                    
                    self.setDisplayLabel()
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


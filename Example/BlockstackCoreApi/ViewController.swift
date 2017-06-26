//
//  ViewController.swift
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//

import UIKit
import BlockstackCoreApi

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func authorize()
    {
        BSBrowserAuth.authorize(appId: "777", name: "HelloBlockStack")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


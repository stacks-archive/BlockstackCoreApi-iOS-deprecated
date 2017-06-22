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
        
        BSCoreApi.ping { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.allNames { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


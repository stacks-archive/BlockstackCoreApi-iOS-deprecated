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
        
        BSCoreApi.nameInfo(for: "muneeb.id", { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        })
        
        BSCoreApi.zoneFile(for: "muneeb.id", with: "b100a68235244b012854a95f9114695679002af9", { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        })
        
        BSCoreApi.namesOwned(on: "bitcoin", for: "1Q3K7ymNVycu3TQoTDUaty8Q5fUVB3feEQ", { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        })
        
        BSCoreApi.allNamespaces({ (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        })
        
        BSCoreApi.namespaceNames(namespace: "id") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.namespacePrice(namespace: "cnn") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.namePrice(name: "logan.id") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.consensusHash(blockchain: "bitcoin") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.pendingTransactions(blockchain: "bitcoin") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.userProfile(username: "fredwilson") { (result, error) in
            if let result = result
            {
                print(String(data: result, encoding: String.Encoding.utf8)!)
            }
        }
        
        BSCoreApi.search(query: "wilson") { (result, error) in
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


//
//  ApiBrowserController.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import BlockstackCoreApi

class ApiBrowserController: UITableViewController {

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ApiBrowserController.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//
// This class is a gateway to examples of all the of api calls.
// each row performs a call and displays the results

import UIKit
import BlockstackCoreApi

class ApiBrowserController: UITableViewController {
    
    //an object to track the different rows.
    enum Rows : Int
    {
        case ping = 0, allNames, nameInfo, zoneFile, namesOwned, allNamespaces, namespacePrice, namePrice, consensusHash,
        pendingTransactions, userProfile, search
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let row = Rows(rawValue: indexPath.row) else
        {
            return cell
        }
        
        cell.detailTextLabel?.text = ""
        
        // Configure the cell...
        switch row {
        case .allNames:
            cell.textLabel?.text = "All Names"
        case .ping:
            cell.textLabel?.text = "Ping"
        case .nameInfo:
            cell.textLabel?.text = "Name Info"
        case .zoneFile:
            cell.textLabel?.text = "Zone File"
        case .namesOwned:
            cell.textLabel?.text = "Names Owned"
        case .allNamespaces:
            cell.textLabel?.text = "All Namespaces"
        case .namespacePrice:
            cell.textLabel?.text = "Namespace Price"
        case .namePrice:
            cell.textLabel?.text = "Name Price"
        case .consensusHash:
            cell.textLabel?.text = "Consensus Hash"
        case .pendingTransactions:
            cell.textLabel?.text = "Pending Transactions"
        case .userProfile:
            cell.textLabel?.text = "User Profile"
        case .search:
            cell.textLabel?.text = "Search"
        }
            
        return cell
    }
    
    //call the correct method when a row is pressed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Configure the cell...
        guard let row = Rows(rawValue: indexPath.row) else
        {
            return
        }
        
        switch row {
        case .allNames:
            allNames()
        case .ping:
            ping()
        case .nameInfo:
            nameInfo()
        case .zoneFile:
            zoneFile()
        case .namesOwned:
            namesOwned()
        case .allNamespaces:
            allNamespaces()
        case .namespacePrice:
            namespacePrice()
        case .namePrice:
            namePrice()
        case .consensusHash:
            consensusHash()
        case .pendingTransactions:
            pendingTransactions()
        case .userProfile:
            userProfile()
        case .search:
            search()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: API Calls
extension ApiBrowserController
{
    func ping()
    {
        BSCoreApi.ping { (result, error) in
            self.showResults(object: result, error: error)
        }
    }
    
    func allNames()
    {
        BSCoreApi.allNames { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func nameInfo(){
        BSCoreApi.nameInfo(for: "muneeb.id", { (result, error) in
            self.showResults(data: result)
        })
    }
    
    func zoneFile(){
        BSCoreApi.zoneFile(for: "muneeb.id", with: "b100a68235244b012854a95f9114695679002af9", { (result, error) in
            self.showResults(data: result)
        })
    }
    
    func namesOwned(){
        BSCoreApi.namesOwned(on: "bitcoin", for: "1Q3K7ymNVycu3TQoTDUaty8Q5fUVB3feEQ", { (result, error) in
            self.showResults(data: result)
        })
    }
    
    func allNamespaces(){
        BSCoreApi.allNamespaces({ (result, error) in
            self.showResults(data: result)
        })
    }
    
    func namespaceNames(){
        BSCoreApi.namespaceNames(namespace: "id") { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func namespacePrice(){
        BSCoreApi.namespacePrice(namespace: "cnn") { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func namePrice(){
        BSCoreApi.namePrice(name: "logan.id") { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func consensusHash(){
        BSCoreApi.consensusHash(blockchain: "bitcoin") { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func pendingTransactions(){
        BSCoreApi.pendingTransactions(blockchain: "bitcoin") { (result, error) in
            self.showResults(data: result)
        }
    }
    
    func userProfile(){
        BSCoreApi.userProfile(username: "fredwilson") { (result, error) in
            self.showResults(object: result, error: error)
        }
    }
    
    func search(){
        BSCoreApi.search(query: "ja") { (result, error) in
            self.showResults(object: result, error: error)
        }
    }
    
}

//MARK: Display helpers to show results
extension ApiBrowserController{
    
    func showResults(object : Codable?, error : Error?)
    {
        let result = object ?? (error?.localizedDescription ?? "No Response")
        let string = String(describing: result)
        showPopup(string: string)
    }
    
    func showResults(data : Data?)
    {
        guard let resultString = resultsAsString(data: data) else
        {
            return
        }
        
        showPopup(string: resultString)
    }
    
    func showPopup(string : String)
    {
        print(string)
        
        let alert = UIAlertController(title: "Results", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resultsAsString(data : Data?) -> String?
    {
        guard let result = data, let dataString = String(data: result, encoding: String.Encoding.utf8) else
        {
            return nil
        }
        
        return dataString
    }
    
    func resultsFromMap(data : Data?) -> String?
    {
        guard let result = data, let dataDictionary = try? JSONSerialization.jsonObject(with: result, options: []) else
        {
            return nil
        }
        
        if let dataDictionary = dataDictionary as? [String : Any]
        {
            return dataDictionary.description
        }else if let dataArray = dataDictionary as? [[String : Any]]
        {
            return dataArray.description
        }
        return nil
    }
    

}

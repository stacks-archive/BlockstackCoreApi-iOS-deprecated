//
//  CoreApi
//  BlockstackCoreApi
//
//  Created by lsease@gmail.com on 06/22/2017.
//  Copyright (c) 2017 lsease@gmail.com. All rights reserved.
//
//  This class defines the core api methods and queries our the blockstack core api to resolve each.



// This is a generic completion handler for our api methods to return results or an error back to the caller.
public typealias ApiCompletionHandler<T> = (_ object: T?, _ error: Error?) -> Void

public class CoreApi
{
    
}

//MARK: Administrative API
extension CoreApi
{
    public static func ping(page : Int = 0, _ handler : @escaping ApiCompletionHandler<PingResponse>)
    {
        var request = URLRequest(url: URL(string: Endpoint.pingPath())!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            let result = PingResponse.deserialize(from: data)
            DispatchQueue.main.async {
                    handler(result, error)
            }
            
        }).resume()
    }
}

//MARK: Names
extension CoreApi{
    
    public static func allNames(page : Int = 0, _ handler : @escaping ApiCompletionHandler<[String]>)
    {
        let url =  URLHelpers.buildURL(with: Endpoint.namesPath(), queryParams: ["page": String(page)])!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var parsedResponse : [String]?
            
            if let data = data{
                let decoder = JSONDecoder()
                parsedResponse = try? decoder.decode([String].self, from: data)
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
        }).resume()
    }
    
    public static func nameInfo(for name: String, _ handler : @escaping ApiCompletionHandler<Data> )
    {
        let url =  Endpoint.namesPath(name: name)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
    
    public static func nameHistory(for name: String, _ handler : @escaping ApiCompletionHandler<Data> )
    {
        let url =  Endpoint.nameHistoryPath(name: name)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
    
    public static func zoneFile(for name: String, with zoneFileHash : String, _ handler : @escaping ApiCompletionHandler<Data> )
    {
        let url =  Endpoint.nameZonefilePath(name: name, zoneFileHash: zoneFileHash)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
}

//MARK: Addresses
extension CoreApi
{
    public static func namesOwned(on blockchain: String, for address : String, _ handler : @escaping ApiCompletionHandler<[String]> )
    {
        let url =  Endpoint.namesOwnedPath(blockChain: blockchain, address: address)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var parsedResponse : [String]?
            
            if let data = data{
                let decoder = JSONDecoder()
                let parsedMap = try? decoder.decode([String : [String]].self, from: data)
                parsedResponse = parsedMap?.values.first
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
            
        }).resume()
    }
}

//MARK: Namespaces
extension CoreApi
{
    public static func allNamespaces( _ handler : @escaping ApiCompletionHandler<[String]> )
    {
        let url =  Endpoint.namespacesPath()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var parsedResponse : [String]?
            
            if let data = data{
                let decoder = JSONDecoder()
                parsedResponse = try? decoder.decode([String].self, from: data)
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
            
        }).resume()
    }
    
    public static func namespaceNames(namespace : String, page : Int = 0, _ handler : @escaping ApiCompletionHandler<[String]>)
    {
        let url =  URLHelpers.buildURL(with: Endpoint.namespaceNamesPath(namespace: namespace), queryParams: ["page": String(page)])!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var parsedResponse : [String]?
            
            if let data = data{
                let decoder = JSONDecoder()
                parsedResponse = try? decoder.decode([String].self, from: data)
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
            
        }).resume()
    }
}

//MARK: Prices
extension CoreApi
{
    //get namespace price
    public static func namespacePrice(namespace : String, _ handler : @escaping ApiCompletionHandler<Data>)
    {
        let url =  Endpoint.namespacePricePath(namespace: namespace)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
    
    //get name price
    public static func namePrice(name : String, _ handler : @escaping ApiCompletionHandler<Data>)
    {
        let url =  Endpoint.namePricePath(name: name)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
}

//MARK: Blockchains
extension CoreApi
{
    public static func consensusHash(blockchain : String, _ handler : @escaping ApiCompletionHandler<String>)
    {
        let url =  Endpoint.consensusPath(blockchain: blockchain)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            var parsedResponse : String?
            
            if let data = data{
                let decoder = JSONDecoder()
                let parsedMap = try? decoder.decode([String:String].self, from: data)
                parsedResponse = parsedMap?.values.first
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
            
        }).resume()
    }
    
    public static func pendingTransactions(blockchain : String, _ handler : @escaping ApiCompletionHandler<Data>)
    {
        let url =  Endpoint.pendingTransactionPath(blockchain: blockchain)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
                DispatchQueue.main.async {
                    handler(data, error)
                }
            
        }).resume()
    }
}

//MARK: Users
extension CoreApi
{
    public static func userProfile(username : String, _ handler : @escaping ApiCompletionHandler<ProfileResponse>)
    {
        let url =  Endpoint.userPath(user: username)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            var parsedResponse : ProfileResponse?
            if let data = data {
                
                let decoder = JSONDecoder()
                if let result = try? decoder.decode([String: ProfileResponse].self, from: data)
                {
                    parsedResponse = result.values.first
                }
            }
            
            DispatchQueue.main.async {
                handler(parsedResponse, error)
            }
            
        }).resume()
    }
}

//MARK: Search
extension CoreApi
{
    public static func search(query : String, _ handler : @escaping ApiCompletionHandler<SearchResponse>)
    {
        let url =  URLHelpers.buildURL(with: Endpoint.searchPath(), queryParams: ["query": query])!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            let results = SearchResponse.deserialize(from: data)
            DispatchQueue.main.async {
                handler(results , error)
            }
        }).resume()
    }
}

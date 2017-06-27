//
//  BSEndpoint.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/22/17.
//  This file defines the endpoints that are called in the core api


struct BSEndpoint
{
    static let BasePath = "\(BSConstants.ServerRoot)/\(BSConstants.ServerPathPrefix)"
    static let PathDelimiter = "/"
    
    struct Subpath
    {
        static let node = "/node"
        static let ping = "/ping"
        static let names = "/names"
        static let history = "/history"
        static let zonefile = "/zonefile"
        static let addresses = "/addresses"
        static let namespaces = "/namespaces"
        static let prices = "/prices"
        static let blockchains = "/blockchains"
        static let consensus = "/consensus"
        static let pending = "/pending"
        static let users = "/users"
        static let search = "/search"
    }
    
    static func pingPath() -> String
    {
        return BasePath + Subpath.node + Subpath.ping
    }
    
    static func namesPath(name : String? = nil) -> String
    {
        var result = BasePath + Subpath.names
        if let name = name{
            result = result + PathDelimiter + name
        }
        return result
    }
    
    static func nameHistoryPath(name : String) -> String
    {
        return namesPath(name: name) + Subpath.history
    }
    
    static func nameZonefilePath(name: String, zoneFileHash : String) -> String
    {
         return namesPath(name: name) + Subpath.zonefile + PathDelimiter + zoneFileHash
    }
    
    static func namesOwnedPath(blockChain : String, address : String) -> String
    {
        return BasePath + Subpath.addresses + PathDelimiter + blockChain + PathDelimiter + address
    }
    
    static func namespacesPath() -> String
    {
        return BasePath + Subpath.namespaces
    }
    
    static func namespaceNamesPath(namespace : String) -> String
    {
        return namespacesPath() + PathDelimiter + namespace + Subpath.names
    }
    
    static func namespacePricePath(namespace : String) -> String
    {
        return BasePath + Subpath.prices + Subpath.namespaces + PathDelimiter + namespace
    }
    
    static func namePricePath(name : String) -> String
    {
        return BasePath + Subpath.prices + Subpath.names + PathDelimiter + name
    }
    
    public static func blockchainPath(_ blockchain : String) -> String
    {
        return BasePath + Subpath.blockchains + PathDelimiter + blockchain
    }
    
    static func consensusPath(blockchain: String) -> String
    {
        return blockchainPath(blockchain) + Subpath.consensus
    }
    
    static func pendingTransactionPath(blockchain: String) -> String
    {
        return blockchainPath(blockchain) + Subpath.pending
    }
    
    static func userPath(user: String) -> String
    {
        let basePath = "\(BSConstants.ServerRoot)/v2"
        return basePath + Subpath.users + PathDelimiter + user
    }
    
    static func searchPath() -> String
    {
        return BasePath + Subpath.search
    }
}

//
//  BSEndpoint.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/22/17.
//


struct BSEndpoint
{
    static let BasePath = "\(BSConstants.ServerRoot)/\(BSConstants.ServerPathPrefix)"
    static let PathDelimiter = "/"
    
    struct Subpath
    {
        static let node = "/node"
        static let ping = "/ping"
        static let names = "/names"
    }
    
    static func pingPath() -> String
    {
        return BasePath + Subpath.node + Subpath.ping
    }
    
    static func namesPath() -> String
    {
        return BasePath + Subpath.names
    }
}

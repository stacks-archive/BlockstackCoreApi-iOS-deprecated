//
//  BSApiResponseTypes.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/27/17.
//  This file lays out various responses that may come through the api by supplying structs that the responses may be
//  easily parsed into using the swift 4 Codable protocol.
//  Note serialization is preformed via a protocol extension Serializable that subclasses Codable
//  Note also, I haven't implemented most of the response objects yet, but this is a demo of how to do it easily.
//  I haven't implemented them all because it seems very subject to change and a change will result in a need to redefine the
//  structures below.

import Foundation
/*
//MARK: ping
public struct BSPingResponse : Serializable
{
    var status : String
    var version : String
}



//MARK: search
public struct BSSearchResponse : Serializable
{
    var results : [BSSearchResult]
    
    public struct BSSearchResult : Serializable
    {
        var profile : BSProfile
    }
}

public struct BSProfile : Serializable
{
    var account : [BSAccount]
    var address : BSAddress
    var description : String
    
    public struct BSAddress : Serializable
    {
        var addressLocality : String
    }
}

public struct BSAccount : Serializable
{
    var identifier : String
    var service : String
    var proofType : String?
    var role : String?
    var proofUrl : String?
}

//MARK: Profile
public struct BSProfileResponse : Serializable
{
    var profile : BSProfile
    
    public struct BSProfile : Serializable
    {
        var account : [BSAccount]
        var description : String
        var address : BSAddress
        var image : [BSImage]
        
        public struct BSAddress : Serializable
        {
            var addressLocality : String
        }
        
        public struct BSImage : Serializable
        {
            var contentUrl : String
            var name : String
        }
    }
}

public struct BSUrlContainer : Serializable{
    var url : String
}

public struct BSAddressContainer : Serializable
{
    var address : String
}

public struct BSFormatContainer : Serializable
{
    var formatted : String
}


//MARK: Serialization Helpers
protocol Serializable : Codable {
    func serialize() -> Data?
    static func deserialize(from data : Data?) -> Self?
    static func deserializeArray(from data : Data?) -> [Self]?
}

extension Serializable
{
    func serialize() -> Data?
    {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    static func deserialize(from data : Data?) -> Self?
    {
        guard let data = data else {
            return nil
        }
        
         let decoder = JSONDecoder()
         return try? decoder.decode(Self.self, from: data)
    }
    
    static func deserializeArray(from data : Data?) -> [Self]?
    {
        guard let data = data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode([Self].self, from: data)
    }
}*/

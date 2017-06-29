//
//  BSApiResponseTypes.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/27/17.
//  This file lays out public various responses that may come through the api by supplying structs that the responses may be
//  easily parsed into using the swift 4 Codable protocol.
//  Note serialization is preformed via a protocol extension Serializable that subclasses Codable
//  Note also, I haven't implemented most of the response objects yet, but this is a demo of how to do it easily.
//  I haven't implemented them all because it seems very subject to change and a change will result in a need to redefine the
//  structures below.

import Foundation

//MARK: ping
public struct BSPingResponse : Serializable
{
    public var status : String
    public var version : String
}

//MARK: search
public struct BSSearchResponse : Serializable
{
    public var results : [BSOneNameSearchResult]
    
    public struct BSSearchResult : Serializable
    {
        public var profile : BSProfile
    }
    
    public struct BSOneNameSearchResult : Serializable
    {
        public var profile : BSOneNameProfile?
        public var username : String?
    }
}

public struct BSOneNameProfile: Serializable
{
    public var avatar : BSUrlContainer?
    public var bio : String?
    public var bitcoin : BSAddressContainer?
    public var cover : BSUrlContainer?
    public var location : BSFormatContainer?
    public var name : BSFormatContainer?
    public var website : String?
}



public struct BSProfile : Serializable
{
    public var account : [BSAccount]
    public var address : BSAddress
    public var description : String
    
    public struct BSAddress : Serializable
    {
        public var addressLocality : String
    }
}

public struct BSAccount : Serializable
{
    public var identifier : String
    public var service : String
    public var proofType : String?
    public var role : String?
    public var proofUrl : String?
}

//MARK: Profile
public struct BSProfileResponse : Serializable
{
    public var profile : BSProfile
    
    public struct BSProfile : Serializable
    {
        public var account : [BSAccount]
        public var description : String
        public var address : BSAddress
        public var image : [BSImage]
        
        public struct BSAddress : Serializable
        {
            public var addressLocality : String
        }
        
        public struct BSImage : Serializable
        {
            public var contentUrl : String
            public var name : String
        }
    }
}

public struct BSUrlContainer : Serializable{
    public var url : String?
}

public struct BSAddressContainer : Serializable
{
    public var address : String?
}

public struct BSFormatContainer : Serializable
{
    public var formatted : String?
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
}

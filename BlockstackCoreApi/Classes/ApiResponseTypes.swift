//
//  ApiResponseTypes.swift
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
public struct PingResponse : Serializable
{
    public var status : String
    public var version : String
}

//MARK: search
public struct SearchResponse : Serializable
{
    public var results : [SearchResult]
    
    public struct SearchResult : Serializable
    {
        public var profile : Profile
        public var username : String
    }
    
}

public struct OneNameSearchResponse : Serializable
{
    public var results : [OneNameSearchResult]
    
    public struct OneNameSearchResult : Serializable
    {
        public var profile : OneNameProfile?
        public var username : String?
    }
}

public struct Profile : Serializable
{
    public var account : [Account]
    public var description : String
    public var address : Address?
    public var image : [Image]?
    public var name : String
    public var website : [UrlContainer]?
    
    public struct Address : Serializable
    {
        public var addressLocality : String
    }
    
    public struct Image : Serializable
    {
        public var contentUrl : String
        public var name : String
    }
}

public struct OneNameProfile: Serializable
{
    public var avatar : UrlContainer?
    public var bio : String?
    public var bitcoin : AddressContainer?
    public var cover : UrlContainer?
    public var location : FormatContainer?
    public var name : FormatContainer?
    public var website : String?
}



public struct Account : Serializable
{
    public var identifier : String
    public var service : String
    public var proofType : String?
    public var role : String?
    public var proofUrl : String?
}

//MARK: Profile
public struct ProfileResponse : Serializable
{
    public var profile : Profile
}

public struct UrlContainer : Serializable{
    public var url : String?
}

public struct AddressContainer : Serializable
{
    public var address : String?
}

public struct FormatContainer : Serializable
{
    public var formatted : String?
}




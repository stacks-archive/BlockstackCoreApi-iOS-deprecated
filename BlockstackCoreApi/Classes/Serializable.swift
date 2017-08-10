//
//  Serializable.swift
//  BlockstackCoreApi
//
//  Created by lsease on 7/13/17.
//  This is a protocol that extends Codable and adds simple serialization
//  and deserialization methods

import Foundation

//MARK: Serialization Helpers
protocol Serializable : Codable {
    func serialize() -> Data?
    static func deserialize(from data : Data?) -> Self?
    static func deserializeArray(from data : Data?) -> [Self]?
    func toDictionary() -> [AnyHashable : Any]?
    static func fromDictionary(_ dictionary : [AnyHashable : Any]) -> Self?
    static func arrayFromDictionary(_ dictionary : [[AnyHashable : Any]]) -> [Self]?
}

extension Serializable
{
    public func toDictionary() -> [AnyHashable : Any]?
    {
        if let data = serialize()
        {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any]
            {
                return json
            }
        }
        return nil
    }
    
    public static func fromDictionary(_ dictionary : [AnyHashable : Any]) -> Self?
    {
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        {
            return Self.deserialize(from: data)
        }
        return nil
    }
    
    public static func arrayFromDictionary(_ dictionaries : [[AnyHashable : Any]]) -> [Self]?
    {
        var results : [Self] = []
        for (dict) in dictionaries
        {
            if let object = fromDictionary(dict)
            {
                results.append(object)
            }
        }
        return results
    }
    
    public func serialize() -> Data?
    {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    public static func deserialize(from data : Data?) -> Self?
    {
        guard let data = data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
    
    public static func deserializeArray(from data : Data?) -> [Self]?
    {
        guard let data = data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode([Self].self, from: data)
    }
}

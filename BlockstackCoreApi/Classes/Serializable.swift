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
}

extension Serializable
{
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

//
//  String+Json.swift
//  BlockstackCoreApi
//
//  Created by lsease on 7/13/17.
//

import Foundation

//convert a dictionary into a json string
extension Dictionary //where Key == String, Value == String
{
    func jsonString() -> String?
    {
        if let theJSONData = try? JSONSerialization.data(
                                withJSONObject: self,
                                options: []) {
            return String(data: theJSONData, encoding: .ascii)
        }
        return nil
    }
}

//convert a json string into a dictionary
extension String
{
    func toJsonDictionary() -> [String : Any]?
    {
        if let data = self.data(using: .utf8) {
            if let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            {
                return dictionary
            }
        }
        return nil
    }
    
}


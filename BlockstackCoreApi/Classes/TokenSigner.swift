//
//  TokenSigner.swift
//  BlockstackCoreApi
//
//  Created by lsease on 7/13/17.
//

import Foundation

public class TokenSigner
{
    public static func sign(requestData : [String : Any]) -> String?
    {
        if let jsonString = requestData.jsonString()
        {
            return jsonString.base64Encoded()
        }
        return nil
    }
    
    public static func decode(responseData : String) -> [String : Any]?
    {
        if let decodedString = responseData.base64Decoded()
        {
            return decodedString.toJsonDictionary()
        }
        return nil
    }
}

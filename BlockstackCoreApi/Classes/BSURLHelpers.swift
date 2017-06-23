//
//  BSURLHelpers.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/23/17.
//

import Foundation

class BSURLHelpers
{
    static func buildURL(with string: String, queryParams: [String : String]) -> URL?
    {
        guard var components = URLComponents(string: string) else
        {
            return nil
        }
        
        var queryItems = components.queryItems ?? [URLQueryItem]()
        for(key, value) in queryParams
        {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url
    }
}

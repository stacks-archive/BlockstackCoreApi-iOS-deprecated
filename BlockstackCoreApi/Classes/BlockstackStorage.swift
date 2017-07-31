//
//  BlockstackStorage.swift
//  BlockstackCoreApi-iOS
//
//  Created by lsease on 7/31/17.
//

import Foundation

public typealias StorageCompletionHandler = (_ data: Data?, _ error: Error?) -> Void

public class BlockstackStorage
{
    // shared instance
    public class func shared() -> BlockstackStorage {
        
        struct Singleton {
            static let instance = BlockstackStorage()
        }
        return Singleton.instance
    }
    
    init()
    {
        
    }
    
    //TODO: Implement
    public func writeToStorage(resourceIdentifier : String, data : Data, handler : StorageCompletionHandler)
    {
        handler(data, nil)
    }
    
    //TODO: Implement
    public func readFromStorage(resourceIdentifier : String, handler : StorageCompletionHandler)
    {
        handler(nil, nil)
    }
}



//
//  JWTUtils.swift
//  BlockstackCoreApi-iOS
//
//  Created by lsease on 8/10/17.
//

import Foundation
import JavaScriptCore
import Security

public class JWTUtils
{
    let context = TokenSigner.shared().context
    
    // shared instance
    public class func shared() -> JWTUtils {
        
        struct Singleton {
            static let instance = JWTUtils()
        }
        return Singleton.instance
    }
    
    init()
    {
    }
    
    public func makeECPrivateKey() -> String
    {
        let result = context.evaluateScript("makeECPrivateKey();")!
        return result.toString()
    }
    
    public func derivePublicKey(privateKey : String) -> String
    {
        let result = context.evaluateScript("SECP256K1Client.derivePublicKey('\(privateKey)')")
        return result!.toString()
    }
    
    public func makeUUID4() -> String
    {
        let result = context.evaluateScript("makeUUID4()")
        return result!.toString()
    }
    
    public func makeDID(from derivedPublicKey : String) -> String
    {
        let result = context.evaluateScript("publicKeyToAddress('\(derivedPublicKey)')")
        return "did:ecdsa-pub:\(result!.toString()!)"
    }
    
    public func generateRandomBytes(length : Int = 32) -> String? {
        
        var keyData = Data(count: length)
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, keyData.count, $0)
        }
        if result == errSecSuccess {
            return keyData.base64EncodedString()
        } else {
            print("Problem generating random bytes")
            return nil
        }
    }
    
    
}


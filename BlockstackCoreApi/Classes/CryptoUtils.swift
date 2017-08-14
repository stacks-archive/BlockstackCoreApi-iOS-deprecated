//
//  CryptoUtils.swift
//  BlockstackCoreApi-iOS
//
//  Created by lsease on 8/10/17.
//

import Foundation
import JavaScriptCore
import Security

public class CryptoUtils
{
    let context = TokenSigner.shared().context
    
    // shared instance
    public class func shared() -> CryptoUtils {
        
        struct Singleton {
            static let instance = CryptoUtils()
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
    
    //MARK: Passphrase
    public func generatePassphrase() -> String
    {
        let result = context.evaluateScript("generateMnemonic()")!
        return result.toString()
    }
    
    public func validatePassphrase(_ passphrase: String) -> Bool
    {
        let result = context.evaluateScript("validateMnemonic('\(passphrase)')")!
        return result.toBool()
    }
    
    public func privateKey(from passphrase: String) -> String?
    {
        let result = context.evaluateScript("mnemonicToSeed('\(passphrase)')")!
        return result.toString()
    }
    
    
}


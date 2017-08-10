//
//  TokenSigner.swift
//  BlockstackCoreApi
//
//  Created by lsease on 7/13/17.
//

import Foundation
import JavaScriptCore


public class TokenSigner
{
    let context = JSContext()!
    
    // shared instance
    public class func shared() -> TokenSigner {
        
        struct Singleton {
            static let instance = TokenSigner()
        }
        return Singleton.instance
    }
    
    init()
    {
        setupJavascriptContext()
    }
    
    private func setupJavascriptContext()
    {
        let bundlePath = Bundle(for: BlockstackAuth.self).path(forResource: "BlockstackCoreApi", ofType: "bundle")
        if let path = bundlePath,
            let bundle = Bundle(path: path),
            let jsPath = bundle.path(forResource: "jsontokens", ofType: "js"),
            let js =  try? String.init(contentsOfFile: jsPath)
        {
            let loaded = context.evaluateScript(js)
            if loaded?.toBool() == true
            {
                print("Jsontokens-js Load successful")
            }
            
            //print any errors
            context.exceptionHandler = {(context, value) in
                print(value!.toString())
            }
        }
    }
    
    public func sign(tokenPayload : [AnyHashable: Any], privateKey : String) -> String?
    {
        //set private key variable
        context.evaluateScript("var rawPrivateKey = '\(privateKey)'")
        
        //get our token signer object
        context.evaluateScript("var tokenSigner = new TokenSigner('ES256k',rawPrivateKey)")
        
        //set our payload to js context
        context.setObject(tokenPayload, forKeyedSubscript: "tokenPayload" as (NSCopying & NSObjectProtocol)!)
        
        //evaluate / sign
        let result = context.evaluateScript("tokenSigner.sign(tokenPayload);")
        
        return result?.toString()
    }
    
    public func decodeToken(_ token : String) -> [AnyHashable : Any]?
    {
        let method = context.objectForKeyedSubscript("decodeToken")
        let result = method!.call(withArguments: [token])
        return result?.toDictionary()
    }
    
    
    public func createUnsecuredToken(tokenPayload : [AnyHashable: Any]) -> String?
    {
        //set our payload to js context
        context.setObject(tokenPayload, forKeyedSubscript: "tokenPayload" as (NSCopying & NSObjectProtocol)!)
        
        let result = context.evaluateScript("createUnsecuredToken(tokenPayload);")
        return result?.toString()
    }
    
    public func verify(token : String, publicKey : String) -> Bool
    {
        //set private key variable
        context.evaluateScript("var rawPublicKey = '\(publicKey)'")
        
        //get our token signer object
        context.evaluateScript("var tokenVerifier = new TokenVerifier('ES256k',rawPublicKey)")
        
        //set our payload to js context
        context.evaluateScript("var token = '\(token)'")
        
        //evaluate / sign
        let result = context.evaluateScript("tokenVerifier.verify(token);")
        
        return result?.toBool() ?? false
    }

}

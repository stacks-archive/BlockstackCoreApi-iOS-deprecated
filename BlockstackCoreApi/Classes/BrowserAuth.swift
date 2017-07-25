//
//  BrowserAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  This class is called by a 3rd party application to check to authorize the app with blockstack.

public class BrowserAuth: NSObject {
    
    static let blockstackUrl = "blockstack://auth"
    //static let blockstackUrl = "http://localhost:8888/auth"
    
    
    //authorization scopes
    public enum Scope : String, Codable {
        case storeWrite = "store_write"
    }
    
    //a retained response handler that is called after the auth callback
    private static var responseHandler : ((String?) -> Void)?
}

//MARK: Main Authorization methods
extension BrowserAuth {
    
    //determine if we can authorize the app, which will tell us if blockstack is installed.
    public static func canAuthorize() -> Bool
    {
        let url = URL(string: blockstackUrl)!
        return UIApplication.shared.canOpenURL(url)
    }
    
    //call blockstack to authorize and then call the completion handler with the
    //resulting token it will retain the completion handler to be called after
    //authorizatin and open the block stack app
    public static func authorize(scopes : [Scope] = [.storeWrite],
                                 handler : @escaping (String?) -> Void)
    {
        //ensure the app is installed
        guard canAuthorize() == true else {
            handler(nil)
            return
        }
        
        //generate private and public keys
        let privateKey = generateAndStoreAppKey()
        let publicKey = derivePublicKey(privateKey: privateKey)
        
        //create our signed auth request params
        guard let unsigned = makeAuthRequest(publicKey: publicKey, scopes: scopes),
            let signed = TokenSigner.sign(requestData: unsigned, privateKey: privateKey) else
        {
            handler(nil)
            return
        }
        
        //encode and create our URL Object
        let urlString = "\(blockstackUrl)?authRequest=\(signed)&target=bsk"
        guard let encodedString = String(format: urlString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        let url = URL(string: encodedString) else {
            handler(nil)
            return
        }
        
        //open the URL and retain our handler
        UIApplication.shared.openURL(url)
        responseHandler = handler
    }
    
    //create a dictionary containing our request data to send to the blockstack app
    public static func makeAuthRequest(publicKey: String, scopes : [Scope]) -> [String: Any]?
    {
        guard let redirect = Bundle.main.infoDictionary?["BlockstackCompletionUri"] as? String else
        {
            return nil
        }
        
        //make all the keys we need to generate our payload
        let did = makeDID(publicKey: publicKey)
        
        //TODO: the old app requires a manifest Uri to be passed in, but a local app cannot service
        //a file in this manner. This needs to be able to be passed in directly.
        let fakeManifestUri = "https://s3.amazonaws.com/bedkin-misc-files/test_manifest.json"
        
        //create and return our payload
        let unsigned : [String : Any] = [
            "jti" : makeUUID4(),
            "iat" : Date().timeIntervalSince1970,
            "exp" : Date().addingTimeInterval(60).timeIntervalSince1970,
            "iss" : did,
            "public_keys" : [publicKey],
            "domain_name" : redirect,
            "manifest_uri" : fakeManifestUri,
            "redirect_uri" : redirect,
            "scopes" : scopes.map({$0.rawValue})]
        return unsigned
    }
}

//MARK: Authorization Callbacks
extension BrowserAuth{
    
    //this method must be called by the authorization seeking app on open URL.
    //It will parse the token from the url
    //and call the previously set completion handler
    public static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
            //TODO: decode the token
            if let handler = responseHandler,
                let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
                let token = queryItems.filter({ $0.name == "authResponse"}).first?.value,
                let decoded = TokenSigner.decodeUnsecured(responseData: token),
                let username = decoded["token"] as? String
            {
                handler(username)
                return true
            }
        return false
    }
}

//MARK: Helper methods.
extension BrowserAuth
{
    static func derivePublicKey(privateKey : String) -> String
    {
        //TODO: Implement
        
//        users json tokens library with these params to dervice public key
//        SECP256K1Client.algorithmName = 'ES256K'
//        SECP256K1Client.ec = new EC('secp256k1')
//        SECP256K1Client.keyEncoder = new KeyEncoder({
//            curveParameters: [1, 3, 132, 0, 10],
//            privatePEMOptions: {label: 'EC PRIVATE KEY'},
//            publicPEMOptions: {label: 'PUBLIC KEY'},
//            curve: SECP256K1Client.ec
//        })
//
        
        return privateKey
    }
    
    static func makeDID(publicKey: String) -> String
    {
        //TODO: Implement
        
        //to address
//        const publicKeyBuffer = new Buffer(publicKey, 'hex')
//        const publicKeyHash160 = bcrypto.hash160(publicKeyBuffer)
//        const address = baddress.toBase58Check(publicKeyHash160, 0x00)
//        return address
        
        //from address
        //return `did:btc-addr:${address}`
        
        return publicKey
    }
    
    static func makeUUID4() -> String
    {
        //TODO: implement the logic able if necessary
        
        //    let d = new Date().getTime()
        //    if (typeof performance !== 'undefined' && typeof performance.now === 'function') {
        //    d += performance.now() // use high-precision timer if available
        //    }
        //    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
        //    const r = (d + Math.random() * 16) % 16 | 0
        //    d = Math.floor(d / 16)
        //    return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16)
        //    })
        
        return UUID.init().uuidString.substring(to: 16)
    }
    
    static func generateAndStoreAppKey() -> String{
        //TODO:
        // const keyPair = new ECPair.makeRandom({ rng: getEntropy })
        //return keyPair.d.toBuffer(32).toString('hex')
        
        //try to load it if it is stored
        if let key = UserDefaults.standard.string(forKey: "BLOCKSTACK_PRIVATE_KEY")
        {
            return key
        }
        
        //generate and save
        let key = UUID.init().uuidString.substring(to: 32)
        UserDefaults.standard.set(key, forKey: "BLOCKSTACK_PRIVATE_KEY")
        UserDefaults.standard.synchronize()
        return key
    }
    
}

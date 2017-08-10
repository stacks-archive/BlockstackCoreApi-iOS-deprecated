//
//  BlockstackAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  This class is called by a 3rd party application to check to authorize the app with blockstack.

public class BlockstackAuth: NSObject {
    
    static let blockstackUrl = "blockstack://auth"
    //static let blockstackUrl = "http://localhost:8888/auth"
    
    
    //authorization scopes
    public enum Scope : String, Codable {
        case storeWrite = "store_write"
    }
    
    //a retained response handler that is called after the auth callback
    private static var responseHandler : ((AuthResponse?) -> Void)?
    
    public static var manifest : AppManifest = AppManifest()
    public static var authResponse : AuthResponse?
    public static var authLoadAttempted = false
    
}

//MARK: Main Authorization methods
extension BlockstackAuth {
    
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
                                 handler : @escaping (AuthResponse?) -> Void)
    {
        //ensure the app is installed
        guard canAuthorize() == true else {
            handler(nil)
            return
        }
        
        //generate private and public keys
        let privateKey = generateAndStoreAppKey()
        let publicKey = JWTUtils.shared().derivePublicKey(privateKey: privateKey)
        
        //create our signed auth request params
        guard let unsigned = makeAuthRequest(publicKey: publicKey, scopes: scopes)?.toDictionary(),
            let signed = TokenSigner.shared().sign(tokenPayload: unsigned, privateKey: privateKey) else
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
    public static func makeAuthRequest(publicKey: String, scopes : [Scope]) -> AuthRequest?
    {
        guard let redirect = Bundle.main.infoDictionary?["BlockstackCompletionUri"] as? String else
        {
            return nil
        }
        
        //TODO: the old app requires a manifest Uri to be passed in, but a local app cannot service
        //a file in this manner. This needs to be able to be passed in directly.
        let fakeManifestUri = "" //"https://s3.amazonaws.com/bedkin-misc-files/test_manifest.json"
        
        var request = AuthRequest()
        
        //create and return our payload
        request.jti = JWTUtils.shared().makeUUID4()
        request.iat = Date().timeIntervalSince1970
        request.exp  = Date().addingTimeInterval(60).timeIntervalSince1970
        request.iss = JWTUtils.shared().makeDID(from: publicKey)
        request.public_keys = [publicKey]
        request.domain_name = redirect
        request.manifest_uri = fakeManifestUri
        request.manifest = manifest
        request.redirect_uri = redirect
        request.scopes = scopes.map({$0.rawValue})
        
        return request
    }
    
    public static func logout()
    {
        if authLoadAttempted == false
        {
            loadAuth()
        }
        
        authResponse = nil
        saveAuth()
    }
    
    public static func loggedIn() -> Bool
    {
        if authLoadAttempted == false
        {
            loadAuth()
        }
        
        return authResponse != nil
    }
    
    public static func currentUserProfile() -> Profile?
    {
        if authLoadAttempted == false
        {
            loadAuth()
        }
        
        return authResponse?.profile
    }
    
    private static func saveAuth()
    {
        UserDefaults.standard.set(authResponse?.serialize(), forKey: "BLOCKSTACK_AUTH_RESPONSE")
        UserDefaults.standard.synchronize()
    }
    
    private static func loadAuth()
    {
        authLoadAttempted = true
        if let authData = UserDefaults.standard.data(forKey: "BLOCKSTACK_AUTH_RESPONSE"),
            let response = AuthResponse.deserialize(from: authData)
        {
            authResponse = response
        }
    }
}

//MARK: Authorization Callbacks
extension BlockstackAuth{
    
    //this method must be called by the authorization seeking app on open URL.
    //It will parse the token from the url
    //and call the previously set completion handler
    public static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
            // decode the token and return
            if let handler = responseHandler,
                let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
                let token = queryItems.filter({ $0.name == "authResponse"}).first?.value,
                let decoded = TokenSigner.shared().decodeToken(token)?["payload"] as? [AnyHashable : Any],
                let response = AuthResponse.fromDictionary(decoded)
            {
                authResponse = response
                saveAuth()
                handler(response)
                return true
            }
        return false
    }
}

//MARK: Helper methods.
extension BlockstackAuth
{
    static func generateAndStoreAppKey() -> String{
        
        //try to load it if it is stored
        if let key = UserDefaults.standard.string(forKey: "BLOCKSTACK_PRIVATE_KEY")
        {
            return key
        }
        
        //generate and save
        let key = JWTUtils.shared().makeECPrivateKey()
        UserDefaults.standard.set(key, forKey: "BLOCKSTACK_PRIVATE_KEY")
        UserDefaults.standard.synchronize()
        return key
    }
}

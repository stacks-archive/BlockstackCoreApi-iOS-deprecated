//
//  BrowserAuth.swift
//  BlockstackCoreApi
//
//  Created by lsease on 6/26/17.
//  This class is called by a 3rd party application to check to authorize the app with blockstack.

public class BrowserAuth: NSObject {
    
    //authorization scopes
    public enum Scope : String {
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
        let url = URL(string: "blockstack://")!
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
        
        //create our signed auth request params
        guard let unsigned = makeAuthRequest(), let signed = TokenSigner.sign(requestData: unsigned) else
        {
            handler(nil)
            return
        }
        
        //encode and create our URL Object
        let urlString = "blockstack://auth?authRequest=\(signed)"
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
    public static func makeAuthRequest() -> [String: Any]?
    {
        guard let redirect = Bundle.main.infoDictionary?["BlockstackCompletionUri"] else
        {
            return nil
        }
        
        let unsigned = ["redirect_uri" : redirect]
        return unsigned
        
        //TODO: needs to look like this
        /*
         jti: makeUUID4(),
         iat: Math.floor(new Date().getTime() / 1000), // JWT times are in seconds
         exp: Math.floor(expiresAt / 1000), // JWT times are in seconds
         iss: null,
         public_keys: [],
         domain_name: appDomain,
         manifest_uri: manifestURI,
         redirect_uri: redirectURI,
         scopes
         */
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
                let decoded = TokenSigner.decode(responseData: token),
                let username = decoded["username"] as? String
            {
                handler(username)
                return true
            }
        return false
    }
}

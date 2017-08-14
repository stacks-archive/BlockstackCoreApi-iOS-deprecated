# BlockstackCoreApi

[![CI Status](http://img.shields.io/travis/lsease@gmail.com/BlockstackCoreApi.svg?style=flat)](https://travis-ci.org/lsease@gmail.com/BlockstackCoreApi)
[![Version](https://img.shields.io/cocoapods/v/BlockstackCoreApi.svg?style=flat)](http://cocoapods.org/pods/BlockstackCoreApi)
[![License](https://img.shields.io/cocoapods/l/BlockstackCoreApi.svg?style=flat)](http://cocoapods.org/pods/BlockstackCoreApi)
[![Platform](https://img.shields.io/cocoapods/p/BlockstackCoreApi.svg?style=flat)](http://cocoapods.org/pods/BlockstackCoreApi)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This project uses Swift 4 and will only run on XCode 9+ (in beta at the time of writing). To download a beta of xcode 9, see developer.apple.com/ios

For a swift 3 compatible version, please see release v0.1.9


## Installation

BlockstackCoreApi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BlockstackCoreApi-iOS"
```

## Usage - Authorization
Complete these setup steps if your app uses Blockstack Authorization.

### Set up

1- create a unique custom url schema for your app to handle auth callbacks from blockstack.
In your info.plist, you must add the following entry allowing the blockstack app to open your application after authorization.
You must also add a blockstack callback url parameter.
```
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>bsk[UNIQUEIDENTIFIER]</string>
    </array>
    </dict>
</array>
<key>BlockstackCompletionUri</key>
<string>bsk[UNIQUEIDENTIFIER]://auth</string>
```

2-  add blockstack to your query schemes so that the app is allowed to verify blockstack is installed
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>blockstack</string>
</array>
```



3- In your app delegate, did open url method, you must pass on the authorization response from blockstack
```
//in order to complete the authorization process we must call the browser auth openURL method so it may
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    if let scheme = url.scheme, scheme.contains("bsk")
    {
        return BlockstackAuth.application(app, open: url, options: options)
    }
    return false
}
```

4- Now, you may verify the blockstack app is installed and that authorization can be completed with:
```
//verify blockstack is installed.
guard BlockstackAuth.canAuthorize() == true else
{
    return
}
```
For more info on install the portal application see: https://github.com/BedKin/BlockstackBrowser-ios

### Authorize
To call blockstack for authorization:
```
BlockstackAuth.authorize() { (token) in
    if let token = token
    {
        //app authorized. Use the provided token
    }
}
```

To Log out
```
BlockstackAuth.logout()
```

To get the current user profile and name after login
```
if let name = BlockstackAuth.currentUserProfile()?.name
{
    //display user name
}
```

### Read and write data after log in

```
//check that we are logged in and serialize some object into data then write it to storage
if BlockstackAuth.loggedIn() == true, let data = myDataObject.serialize()
{
    BlockstackStorage.shared().writeToStorage(resourceIdentifier: "MY_DATA_FILE", data: data , handler: { (writtenData, error) in
        if let _ = writtenData
        {
            //the data was written to file
        }
    }
})
```

```
//check that we are logged in, and if so then read our data from storage and then deserialize it into
//our data object
if BlockstackAuth.loggedIn() == true
{
    BlockstackStorage.shared().readFromStorage(resourceIdentifier: "MY_DATA_FILE", handler: { (readData, error) in
        if let deserialized = Object.deserialize(from: readData)
        {
            //our data has been read and objects deserialized
        }
    })
}
```


## Usage Core API

The blockstack core api can be accessed via CoreApi
For a listing of all the api methods and documentation see core.blockstack.org
```
func ping()
{
    CoreApi.ping { (result, error) in }
}

func allNames()
{
    CoreApi.allNames { (result, error) in }
}

func nameInfo(){
    CoreApi.nameInfo(for: "muneeb.id", { (result, error) in })
}

func zoneFile(){
    CoreApi.zoneFile(for: "muneeb.id", with: "b100a68235244b012854a95f9114695679002af9", { (result, error) in })
}

func namesOwned(){
    CoreApi.namesOwned(on: "bitcoin", for: "1Q3K7ymNVycu3TQoTDUaty8Q5fUVB3feEQ", { (result, error) in })
}

func allNamespaces(){
    CoreApi.allNamespaces({ (result, error) in })
}

func namespaceNames(){
    CoreApi.namespaceNames(namespace: "id") { (result, error) in }
}

func namespacePrice(){
    CoreApi.namespacePrice(namespace: "cnn") { (result, error) in }
}

func namePrice(){
    CoreApi.namePrice(name: "logan.id") { (result, error) in }
}

func consensusHash(){
    CoreApi.consensusHash(blockchain: "bitcoin") { (result, error) in }
}

func pendingTransactions(){
    CoreApi.pendingTransactions(blockchain: "bitcoin") { (result, error) in }
}

func userProfile(){
    CoreApi.userProfile(username: "fredwilson") { (result, error) in }
}

func search(){
    CoreApi.search(query: "taylor") { (result, error) in }
}
```

## Usage: Token Signer (from jsontokens-js)
jsontokens-js has been incoporated into this library through through the JavaScriptCore framework and wrapped inside the TokenSigner class

```
let token = ["iat" : NSNumber(value: 1440713414.85)]
let privateKey = "278a5de700e29faae8e40e366ec5012b5ec63d36ec77e8a2417154cc1d25383f"
let publicKey = "03fdd57adec3d438ea237fe46b33ee1e016eda6b585c3e27ea66686c2ea5358479"

//sign a token
let signed = TokenSigner.shared().sign(tokenPayload: token, privateKey: privateKey)!

//decode a signed token
let decoded = TokenSigner.shared().decodeToken(signed) as! [String : Any]

//sign a token without a private key
let unsecured = TokenSigner.shared().createUnsecuredToken(tokenPayload: token)!

//verify a signed token via public key
let verified = TokenSigner.shared().verify(token: signed, publicKey: publicKey)

```

# Usage CryptoUtils
A few important JWT / private / public key methods have been included in the javascript wrapper and can be accessed as follows
```
let pk = CryptoUtils.shared().makeECPrivateKey()
let pubKey = CryptoUtils.shared().derivePublicKey(privateKey: pk)
let did = CryptoUtils.shared().makeDID(from: pubKey)
let uuid = CryptoUtils.shared().makeUUID4()

//generate a new recovery passphrase (from a new private key)
let passphrase = CryptoUtils.shared().generatePassphrase()

//verify a passphrase
let verifiedPass = CryptoUtils.shared().validatePassphrase(passphrase)

//get the private key from a generated pass phrase
let passphraseKey = CryptoUtils.shared().privateKey(from: passphrase)
```

### jsontoken updates
For info on how to rebuild the jsontokens.js file for updates to jsontokens-js see the file Resources/BlockstackCoreApi/Assets/howto-rebuild-jsontoken.txt

## Author

Logan Sease, Logan@bedkin.com

## License

BlockstackCoreApi is available under the MIT license. See the LICENSE file for more info.

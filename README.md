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
        return BrowserAuth.application(app, open: url, options: options)
    }
    return false
}
```

4- Now, you may verify the blockstack app is installed and that authorization can be completed with:
```
//verify blockstack is installed.
guard BrowserAuth.canAuthorize() == true else
{
    return
}
```
For more info on install the portal application see: https://github.com/BedKin/BlockstackBrowser-ios

5- To call blockstack for authorization:
```
BrowserAuth.authorize() { (token) in
    if let token = token
    {
        //app authorized. Use the provided token
    }
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
    CoreApi.search(query: "ja") { (result, error) in }
}
```



## Author

Logan Sease, Logan@bedkin.com

## License

BlockstackCoreApi is available under the MIT license. See the LICENSE file for more info.

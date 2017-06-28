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
1- create a unique app id for your blockstack app, such as 910412354
2- in your info.plist, you must add the following entry allowing the blockstack app to open your application after authorization
```
<key>CFBundleURLTypes</key>
<array>
    <dict>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>bs910412354</string>
    </array>
    </dict>
</array>
```

also add blockstack to your query schemes so that the app is allowed to verify blockstack is installed
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
    if let scheme = url.scheme, scheme.contains("bs")
    {
        return BSBrowserAuth.application(app, open: url, options: options)
    }
    return false
}
```

4- Now, you may verify the blockstack app is installed and that authorization can be completed with:
```
//verify blockstack is installed.
guard BSBrowserAuth.canAuthorize() == true else
{
    return
}
```
For more info on install the portal application see: https://github.com/BedKin/BlockstackBrowser-ios

5- To call blockstack for authorization:
```
BSBrowserAuth.authorize(appId: "777", name: "HelloBlockStack") { (token) in
    if let token = token
    {
        //app authorized. Use the provided token
    }
}
```

## Usage Core API

The blockstack core api can be accessed via BSCoreApi
For a listing of all the api methods and documentation see core.blockstack.org
```
func ping()
{
    BSCoreApi.ping { (result, error) in }
}

func allNames()
{
    BSCoreApi.allNames { (result, error) in }
}

func nameInfo(){
    BSCoreApi.nameInfo(for: "muneeb.id", { (result, error) in })
}

func zoneFile(){
    BSCoreApi.zoneFile(for: "muneeb.id", with: "b100a68235244b012854a95f9114695679002af9", { (result, error) in })
}

func namesOwned(){
    BSCoreApi.namesOwned(on: "bitcoin", for: "1Q3K7ymNVycu3TQoTDUaty8Q5fUVB3feEQ", { (result, error) in })
}

func allNamespaces(){
    BSCoreApi.allNamespaces({ (result, error) in })
}

func namespaceNames(){
    BSCoreApi.namespaceNames(namespace: "id") { (result, error) in }
}

func namespacePrice(){
    BSCoreApi.namespacePrice(namespace: "cnn") { (result, error) in }
}

func namePrice(){
    BSCoreApi.namePrice(name: "logan.id") { (result, error) in }
}

func consensusHash(){
    BSCoreApi.consensusHash(blockchain: "bitcoin") { (result, error) in }
}

func pendingTransactions(){
    BSCoreApi.pendingTransactions(blockchain: "bitcoin") { (result, error) in }
}

func userProfile(){
    BSCoreApi.userProfile(username: "fredwilson") { (result, error) in }
}

func search(){
    BSCoreApi.search(query: "ja") { (result, error) in }
}
```



## Author

Logan Sease, Logan@bedkin.com

## License

BlockstackCoreApi is available under the MIT license. See the LICENSE file for more info.

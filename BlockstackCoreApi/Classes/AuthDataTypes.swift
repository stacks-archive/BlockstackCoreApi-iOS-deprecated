//
//  AuthDataTypes.swift
//  BlockstackCoreApi-iOS
//
//  Created by lsease on 7/31/17.
//

import Foundation

public struct AppManifest : Serializable
{
    public var shortName : String?
    public var name : String?
    public var iconUrl : String?
    public var themeColorHex : String = "#000000"
    public var backgroundColorHex : String = "#ffffff"
}

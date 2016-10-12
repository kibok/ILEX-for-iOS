//
//  UserData.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/05.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import KeychainAccess

extension DefaultsKeys {
    static let cartList = DefaultsKey<Data>("cartList")
}

class UserData {
    static let keychain = Keychain().accessibility(.alwaysThisDeviceOnly)
    
    class var cartList: Data {
        set {
            Defaults[.cartList] = newValue
        }
        get {
            return Defaults[.cartList]
        }
    }
    
    class var name: String? {
        set {
            keychain["name"] = newValue
        }
        get {
            return keychain["name"]
        }
    }
    
    class var nameKata: String? {
        set {
            keychain["nameKata"] = newValue
        }
        get {
            return keychain["nameKata"]
        }
    }
    
    class var postNumber: String? {
        set {
            keychain["postNumber"] = newValue
        }
        get {
            return keychain["postNumber"]
        }
    }
    
    class var address: String? {
        set {
            keychain["address"] = newValue
        }
        get {
            return keychain["address"]
        }
    }
    
    class var tel: String? {
        set {
            keychain["tel"] = newValue
        }
        get {
            return keychain["tel"]
        }
    }
    
    class var email: String? {
        set {
            keychain["email"] = newValue
        }
        get {
            return keychain["email"]
        }
    }
}

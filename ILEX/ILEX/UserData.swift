//
//  UserData.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/05.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import SwiftyUserDefaults


extension DefaultsKeys {
    static let cartList = DefaultsKey<Data>("cartList")
}


class UserData {
    class var cartList: Data {
        set {
            Defaults[.cartList] = newValue
        }
        get {
            return Defaults[.cartList]
        }
    }
}

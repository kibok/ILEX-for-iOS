//
//  NSNumber.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/30.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

extension NSNumber {
    func priceString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ja_JP")
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: self)!
    }
}

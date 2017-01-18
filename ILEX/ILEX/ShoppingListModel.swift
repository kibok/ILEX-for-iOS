//
//  ShoppingListModel.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/16.
//  Copyright © 2016年 ILEX. All rights reseqrved.
//

import UIKit

class ShoppingListModel: NSObject, NSCoding {
    let date: String
    let id: [String]
    let count: [Int]
    let totalValue: Int
    let orderNumber: String
    
    init(date: String, id: [String], count: [Int], totalValue: Int, orderNumber: String) {
        self.date = date
        self.id = id
        self.count = count
        self.totalValue = totalValue
        self.orderNumber = orderNumber
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "date") as! String
        self.id = aDecoder.decodeObject(forKey: "key") as! [String]
        self.count = aDecoder.decodeObject(forKey: "value") as! [Int]
        self.totalValue = aDecoder.decodeInteger(forKey: "totalValue")
        self.orderNumber = aDecoder.decodeObject(forKey: "orderNumber") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(id, forKey: "key")
        aCoder.encode(count, forKey: "value")
        aCoder.encode(totalValue, forKey: "totalValue")
        aCoder.encode(orderNumber, forKey: "orderNumber")
    }
}

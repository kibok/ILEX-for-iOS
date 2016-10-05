//
//  CartListModel.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/26.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class CartProductModel: NSObject, NSCoding {
    let id: String
    let title: String
    let value: Int
    let image: String
    let visibleCode: Int
    let des: String
    let count: Int
    let size: String
    
    init(id: String, title: String, value: Int, image: String, visibleCode: Int, des: String, count: Int, size: String ) {
        self.id = id
        self.title = title
        self.value = value
        self.image = image
        self.visibleCode = visibleCode
        self.des = des
        self.count = count
        self.size = size
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let value = aDecoder.decodeInteger(forKey: "value")
        let image = aDecoder.decodeObject(forKey: "image") as! String
        let visibleCode = aDecoder.decodeInteger(forKey: "visibleCode")
        let des = aDecoder.decodeObject(forKey: "des") as! String
        let count = aDecoder.decodeInteger(forKey: "count")
        let size = aDecoder.decodeObject(forKey: "size") as! String
            self.init(id: id, title: title, value: value, image: image, visibleCode: visibleCode, des: des, count: count, size: size )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(value, forKey: "value")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(visibleCode, forKey: "visibleCode")
        aCoder.encode(des, forKey: "des")
        aCoder.encode(count, forKey: "count")
        aCoder.encode(size, forKey: "size")
    }
}

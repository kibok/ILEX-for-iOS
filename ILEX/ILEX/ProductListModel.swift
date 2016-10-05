//
//  ProductListModel.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/20.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import Foundation

struct Product {
    let id: String
    let title: String
    let value: Int
    let image: String
    let visibleCode: Int
    let description: String
    let size: String
    let productNumber: String
}

struct ProductListModel {
    var product: Product?
    var products: [Product]?
    
    init(item: NSArray) {
        var array: [Product] = []
        
        for (i, value) in item.enumerated() {
            let nsItem = value as! NSDictionary
            let visibleCode = nsItem.object(forKey: "VisibleCode") as! Int
            
            if visibleCode != 3 {
            
                var id = nsItem.object(forKey: "ID") as! String
                let title = nsItem.object(forKey: "Title") as! String
                let value = nsItem.object(forKey: "Value") as! Int
                let image = nsItem.object(forKey: "Image") as! String
                let description = nsItem.object(forKey: "Description") as! String
                let size = id.components(separatedBy: "-").last!
                let productNumber = id.components(separatedBy: "-")[2]
                                
                array.append(Product(id: id, title: title, value: value, image: image, visibleCode: visibleCode, description: description, size: size, productNumber: productNumber))
            }
        }
        self.products = array
    }
}

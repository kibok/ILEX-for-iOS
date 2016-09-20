//
//  ProductListModel.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/20.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import Foundation

struct ProductModel {
    let id: String
    let title: String
    let value: Int
    let image: NSURL
    let visibleCode: Int
    let description: String
    
    init?(data: NSData) {
        self.id = "id"
        self.title = "title"
        self.value = 3000
        self.visibleCode = 1
        self.description = "description"
        
        guard let imageURL = NSURL(string: "http://itlife009.com/ILEX/resouce/10003-11-102-L.jpg") else {
            return nil
        }
        self.image = imageURL
    }
}


class ProductListModel {
    
    
}
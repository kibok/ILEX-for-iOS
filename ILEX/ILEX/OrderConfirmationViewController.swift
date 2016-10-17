//
//  OrderConfirmationViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import Alamofire

struct OrderItem {
    let JanCode: String
    let ImageUrl: String
    let Title: String
    let Value: String
    let Number: String
}

struct OrderListModel {
    var orderItem: [OrderItem]?

    init(list: [CartProductModel]){
        
        self.orderItem = list.map {item in
            OrderItem(JanCode: item.id, ImageUrl: item.image, Title: item.title, Value: String(item.value), Number: String(item.count))
        }
    }
}

class OrderConfirmationViewController: UIViewController {
    
    var parameters: Parameters = [:]
    let apimanager = APIManager()
    let cartList = NSKeyedUnarchiver.unarchiveObject(with: UserData.cartList) as! [CartProductModel]

    override func viewDidLoad() {
        super.viewDidLoad()

        let item = [
            [
                "JanCode": "String(商品ID)",
                "ImageUrl": "String(商品画像URL)※注文履歴で使用。メールだけなら不要。",
                "Title": "String(商品名)",
                "Value": "String(商品価格)  例)¥3,000",
                "Number": "String(数量)　例)3"
            ],
            [
                "JanCode": "String(商品ID)",
                "ImageUrl": "String(商品画像URL)※注文履歴で使用。メールだけなら不要。",
                "Title": "String(商品名)",
                "Value": "String(商品価格)  例)¥3,000",
                "Number": "String(数量)　例)3"
            ],
            [
                "JanCode": "String(商品ID)",
                "ImageUrl": "String(商品画像URL)※注文履歴で使用。メールだけなら不要。",
                "Title": "String(商品名)",
                "Value": "String(商品価格)  例)¥3,000",
                "Number": "String(数量)　例)3"
            ]
        ]

//        let cartList = NSKeyedUnarchiver.unarchiveObject(with: UserData.cartList) as! [CartProductModel]
        
        let a = OrderListModel(list: self.cartList)
        
        let g = cartList.map {
            [
                "JanCode": $0.id,
                "ImageUrl": $0.image,
                "Title": $0.title,
                "Value": "\($0.value)",
                "Number": "\($0.count)"
            ]
        }
        
        self.parameters = [
            "user_info": [
                "Email": UserData.email,
                "PostCode": UserData.postNumber,
                "Address": UserData.address,
                "NameKanji": UserData.name,
                "NameKatakana": UserData.nameKata,
                "Tell": UserData.tel
            ],
            "item_info": [
                "OrderNumber": "String(注文番号) 乱数７桁でOK",
                "SumValue": 1000,
                "Postage": 1000,
                "OrderItem": g
            ]
        ]
    }
    
    @IBAction func sendOrderRequest(_ sender: AnyObject) {
        self.apimanager.orderRequest(parameters: self.parameters)
//        performSegue(withIdentifier: "toOrderListVC", sender: nil)
        
        //成功
        let id = self.cartList.map { $0.id }
        let count = self.cartList.map { $0.count }
        let totalValue = self.cartList.map { $0.value * $0.count }.reduce(0) { $0 + $1 }

        let a = ShoppingListModel(date: "Today", id: id, count: count, totalValue: totalValue)
        var shppingList: [ShoppingListModel] = []
        
        if UserData.shoppingList.count == 0 {
            shppingList.append(a)
        } else {
            let shppingListNSData = UserData.shoppingList
            shppingList = NSKeyedUnarchiver.unarchiveObject(with: shppingListNSData) as! [ShoppingListModel]
            shppingList.append(a)
        }
        UserData.shoppingList = NSKeyedArchiver.archivedData(withRootObject: shppingList)
        
    }
}


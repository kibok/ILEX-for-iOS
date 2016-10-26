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

struct OrderItems {
    let JanCode: String
    let ImageUrl: String
    let Title: String
    let Value: String
    let Number: String
    
    func toDictionary() -> [String: String?] {
        return [
            "JanCode" : JanCode,
            "ImageUrl" : ImageUrl,
            "Title" : Title,
            "Value" : Value,
            "Number" : Number,
        ]
    }
}

//let params = [
//    "emps": emps.map{e in e.toDictionary()}
//]

class OrderConfirmationViewController: UIViewController {
    
    var parameters: Parameters = [:]
    let apimanager = APIManager()
    let cartList = NSKeyedUnarchiver.unarchiveObject(with: UserData.cartList) as! [CartProductModel]

    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var charge: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var mail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let totalValue = self.cartList.map { $0.value * $0.count }.reduce(0) { $0 + $1 }
        let charge = totalValue > 6000 ? 0 : 800
        
        self.subTotal.text = "¥\(totalValue)"
        self.charge.text = "¥\(charge)"
        self.total.text = "¥\(totalValue + charge)"
        self.name.text = UserData.name == nil ? "未登録" : UserData.name
        self.address.text = UserData.address == nil ? "未登録" : UserData.address
        self.tel.text = UserData.tel == nil ? "未登録" : UserData.tel
        self.mail.text = UserData.email == nil ? "未登録" : UserData.email
        
        let item = cartList.map {
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
                "SumValue": totalValue,
                "Postage": charge,
                "OrderItem": item
            ]
        ]
    }
    
    @IBAction func sendOrderRequest(_ sender: AnyObject) {
        self.apimanager.orderRequest(parameters: self.parameters)
        
        //成功失敗処理必要
        let id = self.cartList.map { $0.id }
        let count = self.cartList.map { $0.count }
        let totalValue = self.cartList.map { $0.value * $0.count }.reduce(0) { $0 + $1 }
        let today = "\(Date())"

        let list = ShoppingListModel(date: today, id: id, count: count, totalValue: totalValue)
        var shppingList: [ShoppingListModel] = []
        
        if UserData.shoppingList.count == 0 {
            shppingList.append(list)
        } else {
            let shppingListNSData = UserData.shoppingList
            shppingList = NSKeyedUnarchiver.unarchiveObject(with: shppingListNSData) as! [ShoppingListModel]
            shppingList.append(list)
        }
        UserData.shoppingList = NSKeyedArchiver.archivedData(withRootObject: shppingList)
        UserData.cartList.removeAll()
        self.showAlert("注文確定", message: "ご注文を承りました。注文内容確認メールが自動的に送信されます。ご登録されたメールをご確認ください。", defaultHandler: { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
        })
    }
}


//
//  OrderConfirmationViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import Alamofire

class OrderConfirmationViewController: UIViewController {
    
    var parameters: Parameters = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = [
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
        
        let parameters: Parameters = [
            "user_info": [
                "Email": "dearkibok@gamil.com",
                "PostCode": "String(郵便番号)",
                "Address": "String(住所)",
                "NameKanji": "String(漢字の名前)",
                "NameKatakana": "String(カタカナの名前)",
                "Tell": "Stirng(電話番号)"
            ],
            "item_info": [
                "OrderNumber": "String(注文番号) 乱数７桁でOK",
                "SumValue": 1000,
                "Postage": 1000,
                "OrderItem": a
            ]
        ]
        
        self.parameters = parameters
    }
    
    
    @IBAction func sendOrderRequest(_ sender: AnyObject) {
        self.a(parameters: self.parameters)
    }
    
    func a(parameters: Parameters){
        Alamofire.request("http://itlife009.com/ILEX/test/test_order_mail.php", method: .post, parameters: self.parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseString {
            response in
            
            if let a = response.result.value {
                print(a)
            } else {
                print("error")
            }
        }
    }
}

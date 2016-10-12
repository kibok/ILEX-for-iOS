//
//  APIManager.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/23.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    var viewModel: ProductListModel!
    
    func getItemList(completionHandler: @escaping (NSArray) -> Void) {
        Alamofire.request("http://itlife009.com/ILEX/ilex_itemlist.json").responseJSON { response in
            if response.result.isSuccess {
                let json = response.result.value
                let jsonDic = json as! NSDictionary
                let item = jsonDic.object(forKey: "Item") as! NSArray
                completionHandler(item)
            }
        }
    }
    
//    func orderRequest(parameters: Parameters) {
//        Alamofire.request("http://itlife009.com/ILEX/order_mail.php", method: .post, parameters: parameters ,encoding: JSONEncoding.default).responseString { response in
//            if let result = response.result.value {
//                print(result)
//            } else {
//                print("error")
//            }
//        }
//    }
    
    func orderRequest(parameters: Parameters){
        Alamofire.request("http://itlife009.com/ILEX/test/test_order_mail.php", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseString {
            response in
            
            if let a = response.result.value {
                print(a)
            } else {
                print("error")
            }
        }
    }
    
    func getMailCertification(parameters: Parameters) {
                
        Alamofire.request("http://itlife009.com/ILEX/test/check_mail.php", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseString {
            response in

            if let value = response.result.value {
                print(value)
            } else {
                print("error")
            }
        }
    }
    
    
}

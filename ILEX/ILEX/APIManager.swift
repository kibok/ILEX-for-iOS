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
    
    func orderRequest(parameters: Parameters){
        Alamofire.request("http://itlife009.com/ILEX//mail/order/ios.php", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseString {
            response in
        }
    }
    
    func getMailCertification(parameters: Parameters) {
        Alamofire.request("http://itlife009.com/ILEX/mail/register/ios.php", method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseString {
            response in
        }
    }
    
    func getVersion(completionHandler: @escaping (NSDictionary) -> Void) {
        Alamofire.request("http://itlife009.com/ILEX/config/state.json").responseJSON { response in
            if response.result.isSuccess {
                let json = response.result.value
                let jsonDic = json as! NSDictionary
                let item = jsonDic.object(forKey: "iOS") as! NSDictionary
                completionHandler(item)
            }
        }
    }
}

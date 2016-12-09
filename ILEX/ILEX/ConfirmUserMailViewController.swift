//
//  ConfirmUserMailViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/09.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import Alamofire

class ConfirmUserMailViewController: UIViewController {

    @IBOutlet weak var userMailTextField: UITextField!
    let apiManager = APIManager()
    var password: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func requestConfirmUserMail(_ sender: AnyObject) {
        if !self.checkMailValidation() {
            return
        }
        let parameters: Parameters = ["to":self.userMailTextField.text!, "password":self.setPassword()]
        self.apiManager.getMailCertification(parameters: parameters)
        performSegue(withIdentifier: "toCheckPasswordVC", sender: nil)
    }
    
    func checkMailValidation() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self.userMailTextField.text)
        return result
    }
    
    func setPassword() -> String {
        let letters : NSString = "0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: 4)
        for _ in 0 ..< 4 {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        self.password = randomString as String
        return randomString as String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCheckPasswordVC") {
            let vc = (segue.destination as? CheckPasswordViewController)!
            vc.password = self.password
            vc.email = self.userMailTextField.text!
        }
    }
}

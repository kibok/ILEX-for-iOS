//
//  CheckPasswordViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/09.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class CheckPasswordViewController: UIViewController {
    var password: String = ""
    var email: String = ""
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.password)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        if self.textField.text == self.password {
            UserData.email = self.email
            _ = navigationController?.popToRootViewController(animated: true)            
            self.showAlert(message: "メールの設定ができました")
        } else {
            self.showAlert(message: "メールの設定ができませんでした")
        }
    }
}

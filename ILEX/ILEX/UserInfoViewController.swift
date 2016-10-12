//
//  UserInfoViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/09.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import KeychainAccess

class UserInfoViewController: UITableViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameKatakana: UILabel!
    @IBOutlet weak var postNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text = UserData.name
        self.nameKatakana.text = UserData.nameKata
        self.postNumber.text = UserData.postNumber
        self.address.text = UserData.address
        self.tel.text = UserData.tel
        self.email.text = UserData.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


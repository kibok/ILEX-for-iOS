//
//  UserInfoViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/09.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class UserInfoViewController: UITableViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameKatakana: UITextField!
    @IBOutlet weak var postNumber: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text = "name"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


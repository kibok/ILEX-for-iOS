//
//  SettingTableViewController.swift
//  ILEX
//
//  Created by Kibok on 2016. 9. 19..
//  Copyright © 2016년 ILEX. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTextField.text = UserData.email == nil ? "未登録" : UserData.email
        self.addressTextField.text = UserData.address == nil ? "未登録" : UserData.address
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToTop(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

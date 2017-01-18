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
    @IBOutlet weak var versionTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor()
        if let versionName = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionTextLabel.text = versionName
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emailTextField.text = UserData.email == nil ? "未登録" : UserData.email
        self.addressTextField.text = UserData.address == nil ? "未登録" : UserData.address
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToTop(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

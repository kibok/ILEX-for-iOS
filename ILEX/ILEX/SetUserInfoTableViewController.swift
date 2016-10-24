//
//  SetUserInfoTableViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/11.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class SetUserInfoTableViewController: UITableViewController {

    
    @IBOutlet weak var postNumber: UITextField!
    
    @IBOutlet weak var hu: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var buildName: UITextField!
    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var seiKanji: UITextField!
    @IBOutlet weak var nameKanji: UITextField!
    @IBOutlet weak var seiKata: UITextField!
    @IBOutlet weak var nameKata: UITextField!
    
    @IBOutlet weak var tel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func setUserInfo(_ sender: Any) {
        
        UserData.name = "\(self.seiKanji.text!) \(self.nameKanji.text!)"
        UserData.name = "\(self.seiKata.text!) \(self.nameKata.text!)"
        UserData.address = "\(self.hu.text!)\(self.city.text!)\(self.address.text!)\(self.buildName.text!)\(self.number.text!)"
        UserData.postNumber = "\(self.postNumber.text!)"
        UserData.tel = "\(self.tel.text!)"
        
        _ = navigationController?.popViewController(animated: true)
    }    
}

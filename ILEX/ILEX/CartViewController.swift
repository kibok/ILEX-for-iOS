//
//  CartViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate {

    @IBOutlet var cartTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    var cartList: [CartProductModel] = []
    let userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self

        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        self.cartTableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        self.cartTableView.tableHeaderView = nil
        if UserData.cartList.count == 0 {
            self.cartTableView.isHidden = true
        } else {
            self.cartTableView.isHidden = false
            self.cartList = NSKeyedUnarchiver.unarchiveObject(with: UserData.cartList) as! [CartProductModel]
            self.cartTableView.reloadData()
        }
        self.productCount.text = "合計\(self.cartList.count)店"
        self.totalPrice.text = "合計金額 ¥ \(self.cartList.map { $0.value * $0.count }.reduce(0) { $0 + $1 })(税別)"
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.tag = (indexPath as NSIndexPath).row
        cell.cartTitle.text = self.cartList[indexPath.row].title
        cell.cartCount.text = "数量:\(self.cartList[indexPath.row].count)個"
        cell.cartValue.text = "¥\(self.cartList[indexPath.row].value * self.cartList[indexPath.row].count)(税別)"
        cell.cartImage.downloadedFrom(link: self.cartList[indexPath.row].image)
        cell.delegate = self   
        return cell
    }
    
    func cartTableViewCell(tag: Int) {
        self.cartList.remove(at: tag)
        if self.cartList.count == 0 {
            self.cartTableView.isHidden = true
//            self.footerView.isHidden = true
            UserData.cartList.removeAll()
        } else {
            let cartListNSData = NSKeyedArchiver.archivedData(withRootObject: self.cartList)
            UserData.cartList = cartListNSData
            self.cartTableView.reloadData()
        }
        self.productCount.text = "合計 \(self.cartList.count) 店"
        self.totalPrice.text = "合計金額 ¥ \(self.cartList.map { $0.value * $0.count }.reduce(0) { $0 + $1 })(税別)"
    }
    
    @IBAction func didTapButton(_ sender: Any) {
//        if UserData.email == nil || UserData.address == nil {
//            self.showAlert(message: "「メールアドレス」と「お届け先」が登録されていることを確認してください。設定画面に移動しますか？")
//        } else if self.cartList.count == 0 {
//            self.showAlert(message: "カートに商品がありません。")
//        } else {
            performSegue(withIdentifier: "toOrderConfirmVC", sender: nil)
//        }
    }
}

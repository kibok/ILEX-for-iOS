//
//  OrderListViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/11.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var shppingList: [ShoppingListModel] = []
    var selectedList : ShoppingListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let shppingListNSData = UserData.shoppingList

        if shppingListNSData.count == 0 {
            self.showAlert(message: "注文履歴がありません。")
        } else {
            let list = NSKeyedUnarchiver.unarchiveObject(with: shppingListNSData) as! [ShoppingListModel]
            
            self.shppingList = Array(list.reversed())
        }
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = self.shppingList[indexPath.row].date
        let label2 = cell.viewWithTag(2) as! UILabel
        label2.text = "\(self.shppingList[indexPath.row].totalValue)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedList = self.shppingList[indexPath.row]
        performSegue(withIdentifier: "toOrderListDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toOrderListDetailVC") {
            let vc = (segue.destination as? OrderListDetailViewController)!
            
            vc.shoppingListModel = selectedList
        }
    }
}



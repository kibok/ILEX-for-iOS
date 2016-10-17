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
        self.shppingList = NSKeyedUnarchiver.unarchiveObject(with: shppingListNSData) as! [ShoppingListModel]
        
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
        let a = cell.viewWithTag(1) as! UILabel
        a.text = self.shppingList[indexPath.row].date
        let b = cell.viewWithTag(2) as! UILabel
        b.text = "\(self.shppingList[indexPath.row].totalValue)"
        
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



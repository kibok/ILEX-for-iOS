//
//  OrderListDetailViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/17.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class OrderListDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var shoppingListModel: ShoppingListModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingListModel.id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        let imageView = cell.viewWithTag(4) as! UIImageView
        let label1 = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        let label3 = cell.viewWithTag(3) as! UILabel

        let list = ProductViewModel.products.filter { $0?.id == self.shoppingListModel.id[indexPath.row] }
        
        imageView.downloadedFrom(link: (list[0]?.image)!)
        label1.text = list[0]?.title
        label2.text = "\(list[0]!.value)"
        label3.text = "\(self.shoppingListModel.count[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

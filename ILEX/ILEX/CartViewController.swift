//
//  CartViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit



class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        self.cartTableView.registerNib(nib, forCellReuseIdentifier: "CartTableViewCell")
        self.cartTableView.tableHeaderView = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
        cell.tag = indexPath.row
        return cell
    }
}

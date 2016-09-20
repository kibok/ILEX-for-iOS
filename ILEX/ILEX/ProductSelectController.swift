//
//  ProductSelectViewController
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class ProductSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productTalbeView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTalbeView.delegate = self
        self.productTalbeView.dataSource = self
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTalbeView.registerNib(nib, forCellReuseIdentifier: "ProductTableViewCell")
        self.productTalbeView.tableHeaderView = nil
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductTableViewCell", forIndexPath: indexPath) as! ProductTableViewCell
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
}


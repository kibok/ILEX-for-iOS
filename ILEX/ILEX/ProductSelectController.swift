//
//  ProductSelectViewController
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import Alamofire

class ProductSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productTalbeView: UITableView!
    
    let apiManager = APIManager()
    var viewModel: ProductListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTalbeView.delegate = self
        self.productTalbeView.dataSource = self
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTalbeView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        self.productTalbeView.tableHeaderView = nil
        
        self.getItemLsit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let count = self.viewModel?.products?.count else { return 0 }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        guard let item = self.viewModel else { return cell }
        let itemIndexRow = item.products?[indexPath.row]

        
        cell.itemImage?.downloadedFrom(link: (itemIndexRow?.image)!)

        
        cell.itemDescription.text = itemIndexRow?.description
        cell.itemTitle.text = itemIndexRow?.title
        cell.itemValue.text = "¥\(itemIndexRow!.value)円"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProductDetailViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProductDetailViewController") {
            let vc = (segue.destination as? ProductDetailViewController)!
            guard let row = self.productTalbeView.indexPathForSelectedRow?.row else { return }
            vc.viewModel = self.viewModel?.products?[row]
        }
    }
    
    // MARK: - APINetwork
    
    func getItemLsit(){
        self.apiManager.getItemList(completionHandler: { item in
            self.viewModel = ProductListModel(item: item)
            self.productTalbeView.reloadData()
        })
    }
}


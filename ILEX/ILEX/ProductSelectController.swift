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
    var viewModel: ProductListModel?
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productTalbeView.delegate = self
        self.productTalbeView.dataSource = self
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTalbeView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        self.productTalbeView.tableHeaderView = nil
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_ilex"))
        self.getItemLsit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel?.products?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
                
        guard let item = self.viewModel else { return cell }
        let itemIndexRow = item.products?[indexPath.row]

        if itemIndexRow?.visibleCode == 1 {
            cell.itemImage?.downloadedFrom(link: (itemIndexRow?.image)!)
            cell.itemDescription.text = itemIndexRow?.description
            cell.itemTitle.text = itemIndexRow?.title
            cell.itemValue.text = "¥\(itemIndexRow!.value)円"
        }
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
            let size = self.viewModel?.products?.filter{ $0.productNumber == self.viewModel?.products?[row].productNumber }
                .map { $0.size }
            vc.size = size
            
            vc.list = self.viewModel?.products?.filter{ $0.productNumber == self.viewModel?.products?[row].productNumber }
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


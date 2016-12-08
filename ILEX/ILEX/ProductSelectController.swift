//
//  ProductSelectViewController
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ProductSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productTalbeView: UITableView!
    var viewModel: ProductListModel?
    var list: [Product] = []
    let apiManager = APIManager()
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productTalbeView.delegate = self
        self.productTalbeView.dataSource = self
        
        if !UserData.didLoginAtFirstTime {
            UserData.didLoginAtFirstTime = true
            self.showFirstAlert(title: "アプリをインストールしていただきありがとうございます。\n本サービスをご利用する前に、利用規約をご一読ください。", message: nil, defaultHandler: { _ in
                let storyboard = UIStoryboard(name: "Setting", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "RuleWebViewController")
                self.navigationController?.pushViewController(vc, animated: true)
            }, cancelHandler: nil)
        }
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTalbeView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        self.productTalbeView.tableHeaderView = nil
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_ilex"))
     
        self.getItemLsit()
        
        ProductViewModel.loadProducts()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(ProductSelectViewController.refresh), for: .valueChanged)
        self.productTalbeView.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let item = self.viewModel else { return 0 }
        let a = item.products?.filter{ $0.visibleCode == 1 }
        print(a!.count)
        return a!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        let url = URL(string: self.list[indexPath.row].image)
        cell.itemImage.sd_setImage(with: url)
        cell.itemDescription.text = self.list[indexPath.row].description
        cell.itemTitle.text = self.list[indexPath.row].title
        cell.itemValue.text = "\(NSNumber(value: self.list[indexPath.row].value).priceString())（税込）"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProductDetailViewController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProductDetailViewController") {
            let vc = (segue.destination as? ProductDetailViewController)!
            guard let row = self.productTalbeView.indexPathForSelectedRow?.row else { return }
            vc.viewModel = self.list[row]
            let size = self.viewModel?.products?.filter{ $0.productNumber == self.list[row].productNumber }
                .map { $0.size }
            vc.size = size
            vc.list = self.viewModel?.products?.filter{ $0.productNumber == self.list[row].productNumber }
        }
    }
    
    // MARK: - APINetwork
    
    func getItemLsit(){
        self.apiManager.getItemList(completionHandler: { item in
            self.viewModel = ProductListModel(item: item)
            self.list = (self.viewModel?.products?.filter { $0.visibleCode == 1 })!
            self.productTalbeView.reloadData()
        })
    }
    
    // MARK: - RefreshControll

    func refresh()
    {
        self.productTalbeView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showFirstAlert(title: String?, message: String?, defaultHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "利用規約へ", style: .default, handler: defaultHandler)
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "後で見る", style: .cancel, handler: cancelHandler)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

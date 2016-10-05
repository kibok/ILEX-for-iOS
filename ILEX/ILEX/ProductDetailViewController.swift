//
//  ProductDetailViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var plusMinusButton: PlusMinusButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var sizeButton: UIButton!
    
    var viewModel: Product?
    var size: [String]?
    var selectedSize: String?
    private var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plusMinusButton.plus.addTarget(self, action: #selector(ProductDetailViewController.touchUpInsidePlus(sender:)), for: .touchUpInside)
        self.plusMinusButton.minus.addTarget(self, action: #selector(ProductDetailViewController.touchUpInsideMinus(sender:)), for: .touchUpInside)
        self.itemImage.downloadedFrom(link: (self.viewModel?.image)!)
        self.sizeButton.setTitle(size?.first, for: .normal)
        self.selectedSize = self.size?.first
        
    }

    func touchUpInsidePlus(sender: AnyObject) {
        if self.count < 30 {
            self.count += 1
        }
        self.plusMinusButton.label.text = "\(self.count)"
    }
    
    func touchUpInsideMinus(sender: AnyObject) {
        if self.count > 1 {
            self.count -= 1
        }
        self.plusMinusButton.label.text = "\(self.count)"
    }

    @IBAction func addProductToCart(_ sender: AnyObject) {
        
        let userDefaults = UserDefaults.standard
        let cartProductModel = CartProductModel(id: (self.viewModel?.id)!, title: (self.viewModel?.title)!, value: (self.viewModel?.value)!, image: (self.viewModel?.image)!, visibleCode: (self.viewModel?.visibleCode)!, des: (self.viewModel?.description)!, count: self.count, size: self.selectedSize!)
        
        var cartList: [CartProductModel] = []
        
        
        
        //コードを綺麗に！
        if userDefaults.data(forKey: "cartList") == nil {
            cartList.append(cartProductModel)
        } else {
            let cartListNSData = userDefaults.object(forKey: "cartList") as! Data
            cartList = NSKeyedUnarchiver.unarchiveObject(with: cartListNSData) as! [CartProductModel]
            if checkCarList(cartList: cartList, cartProductModel: cartProductModel) {
                cartList.append(cartProductModel)
            } else {
                let index = findIndex(cartList: cartList, cartProductModel: cartProductModel)
                cartList[index] = cartProductModel
            }
        }
        //
        
        
        
        let cartListNSData = NSKeyedArchiver.archivedData(withRootObject: cartList)
        userDefaults.set(cartListNSData, forKey: "cartList")
        userDefaults.synchronize()
    }
    
    func checkCarList(cartList: [CartProductModel], cartProductModel: CartProductModel) -> Bool {
        let noexistInCart = cartList.filter { $0.id == cartProductModel.id }
        return noexistInCart.count == 0 ? true : false
    }
    
    func findIndex(cartList: [CartProductModel], cartProductModel: CartProductModel) -> Int {
        for index in cartList.startIndex ..< cartList.endIndex {
            if cartList[index].id == cartProductModel.id {
                return index
            }
        }
        return 0
    }
    
    @IBAction func toSizePickerView(_ sender: UIButton) {
        performSegue(withIdentifier: "toSizePickerViewController", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIButton {
            let vc = segue.destination as! SizePickerViewController
            print(self.size)
            vc.size = self.size
        }
    }
    
    @IBAction func didTapOK(segue: UIStoryboardSegue) {
        if let vc = segue.source as? SizePickerViewController {
            self.selectedSize = size?[vc.selectedRow]
            self.sizeButton.setTitle(size?[vc.selectedRow], for: .normal)
        }
    }
}

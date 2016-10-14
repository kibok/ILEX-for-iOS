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
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productValue: UILabel!
    
    var viewModel: Product!
    var list: [Product]!
    var size: [String]?
    var selectedSize: String!
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plusMinusButton.button.maximumValue = 30
        self.plusMinusButton.button.minimumValue = 1
        self.plusMinusButton.button.value = 1
        self.plusMinusButton.button.stepValue = 1
        
        self.plusMinusButton.button.addTarget(self, action: #selector(ProductDetailViewController.stepperOneChanged(stepper:)), for: UIControlEvents.valueChanged)
        
        self.itemImage.downloadedFrom(link: self.list[0].image)
        self.sizeButton.setTitle(self.list[0].size, for: .normal)
        self.selectedSize = self.list[0].size
        self.title = self.list[0].title
        self.productValue.text = "\(self.list[0].value)"
        self.productTitle.text = self.list[0].title
        self.productDescription.text = self.list[0].description
    }
    
    internal func stepperOneChanged(stepper: UIStepper){
        self.count = Int(stepper.value)
        self.plusMinusButton.label.text = "\(Int(stepper.value))"
    }

    @IBAction func addProductToCart(_ sender: AnyObject) {
        
        let product = self.list.filter { $0.size == self.selectedSize }.first!
        let cartProductModel = CartProductModel(id: product.id, title: product.title, value: product.value, image: product.image, visibleCode: product.visibleCode, des: product.description, count: self.count, size: self.selectedSize)
        
        var cartList: [CartProductModel] = []
        
        if UserData.cartList.count == 0 {
            cartList.append(cartProductModel)
        } else {
            let cartListNSData = UserData.cartList
            cartList = NSKeyedUnarchiver.unarchiveObject(with: cartListNSData) as! [CartProductModel]
            if checkCarList(cartList: cartList, cartProductModel: cartProductModel) {
                cartList.append(cartProductModel)
            } else {
                let index = findIndex(cartList: cartList, cartProductModel: cartProductModel)
                cartList[index] = cartProductModel
            }
        }
        self.showAlert(message: "カートに追加しました。")
        let cartListNSData = NSKeyedArchiver.archivedData(withRootObject: cartList)
        UserData.cartList = cartListNSData
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
            vc.size = self.size
        }
    }
    
    @IBAction func didTapOK(segue: UIStoryboardSegue) {
        if let vc = segue.source as? SizePickerViewController {
            self.selectedSize = self.list[vc.selectedRow].size
            self.sizeButton.setTitle(self.list[vc.selectedRow].size, for: .normal)
            self.itemImage.downloadedFrom(link: self.list[vc.selectedRow].image)
            self.title = self.list[vc.selectedRow].title
        }
    }
}

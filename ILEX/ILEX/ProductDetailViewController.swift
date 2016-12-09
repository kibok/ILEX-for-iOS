//
//  ProductDetailViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var plusMinusButton: PlusMinusButton!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productValue: UILabel!
    @IBOutlet weak var pickerTextField: UITextField!
    let pickerView = UIPickerView()
    
    var viewModel: Product!
    var list: [Product]!
    var size: [String]?
    var selectedSize: String!
    var count = 1

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.plusMinusButton.button.maximumValue = 20
        self.plusMinusButton.button.minimumValue = 1
        self.plusMinusButton.button.value = 1
        self.plusMinusButton.button.stepValue = 1
        
        self.plusMinusButton.button.addTarget(self, action: #selector(ProductDetailViewController.stepperOneChanged(stepper:)), for: UIControlEvents.valueChanged)
        
        self.itemImage.downloadedFrom(link: self.list[0].image)
        self.selectedSize = self.list[0].size
        self.title = self.list[0].title
        self.productValue.text = "\(NSNumber(value: self.list[0].value).priceString())(税込)"
        self.productTitle.text = self.list[0].title
        self.productDescription.text = self.list[0].description
        self.pickerTextField.isHidden = true
        
        pickerView.delegate = self
        self.pickerTextField.inputView = pickerView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let notification = NotificationCenter.default
        notification.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
            self.showAlert(message: "カートに追加しました。")
        } else {
            let cartListNSData = UserData.cartList
            cartList = NSKeyedUnarchiver.unarchiveObject(with: cartListNSData) as! [CartProductModel]
            if checkCarList(cartList: cartList, cartProductModel: cartProductModel) {
                cartList.append(cartProductModel)
                self.showAlert(message: "カートに追加しました。")
            } else {
//                let index = findIndex(cartList: cartList, cartProductModel: cartProductModel)
//                cartList[index] = cartProductModel
                self.showAlert(message: "すでにカートに追加されている商品です。")
            }
        }
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

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.list[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedSize = self.list[row].size
        self.productTitle.text = self.list[row].title
        self.title = self.list[row].title
        let price = NSNumber(value: self.list[row].value).priceString()
        self.productValue.text = "\(price) (税込)"
        self.itemImage.downloadedFrom(link: self.list[row].image)
    }
    
    @IBAction func changeProductSize() {
        self.pickerTextField.becomeFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pickerTextField.resignFirstResponder()
        return true
    }
}

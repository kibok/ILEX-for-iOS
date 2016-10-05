//
//  SizePickerViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/29.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class SizePickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var sizePickerView: UIPickerView!
    
    var size: [String]?
    var selectedRow = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sizePickerView.delegate = self
        self.sizePickerView.dataSource = self        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.size!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.size?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = row
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.sizePickerView.frame.width, height: 40)
        label.text = self.size?[row]
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }

}

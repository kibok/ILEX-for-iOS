//
//  TextFieldWithDoneButton.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/23.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class TextFieldWithDoneButton: UITextField {
    
    var numberToolbar: UIToolbar?
    
    override func awakeFromNib() {
        self.numberToolbar = UIToolbar(frame: CGRect())
        self.numberToolbar?.barStyle = UIBarStyle.default
        self.numberToolbar?.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TextFieldWithDoneButton.doneAction))
        ]
        self.numberToolbar?.sizeToFit()
        self.inputAccessoryView = self.numberToolbar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.numberToolbar?.superview?.frame.width ?? 0
        self.numberToolbar?.frame = CGRect(x: 0, y:0, width: width, height: 44)
    }
    
    func doneAction() {
        self.endEditing(true)
    }
}

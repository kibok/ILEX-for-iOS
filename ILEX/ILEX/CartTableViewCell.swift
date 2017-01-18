//
//  CartTableViewCell.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func cartTableViewCell(tag: Int)
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartCount: UILabel!
    @IBOutlet weak var cartValue: UILabel!
    @IBOutlet weak var cartTitle: UILabel!
    
    weak var delegate: CartTableViewCellDelegate?
    
    @IBAction func deleteItem(_ sender: AnyObject) {
        self.delegate?.cartTableViewCell(tag: self.tag)
    }
}

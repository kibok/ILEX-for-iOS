//
//  ProductTableViewCell.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemValue: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

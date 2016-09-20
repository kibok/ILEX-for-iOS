//
//  CartTableViewCell.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/16.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

@objc protocol ReservationListTableViewCellDelegate {
    func a()
}
class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    weak var delegate: ReservationListTableViewCellDelegate?

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteList(sender: AnyObject) {
        print(self.tag)
        self.delegate?.a()
    }
}

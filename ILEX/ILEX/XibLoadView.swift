//
//  XibLoadView.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/09/20.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class XibLoadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    init() {
        super.init(frame: CGRect())
        loadViewFromNib()
    }

    func loadViewFromNib() {
        let nibname = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last
        let view = Bundle.main.loadNibNamed(nibname!, owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.frame = bounds
    }
}

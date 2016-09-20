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
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.plusMinusButton.plus.addTarget(self, action: #selector(ProductDetailViewController.touchUpInsidePlus(sender:)), for: .touchUpInside)
        self.plusMinusButton.minus.addTarget(self, action: #selector(ProductDetailViewController.touchUpInsideMinus(sender:)), for: .touchUpInside)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func touchUpInsidePlus(sender: AnyObject) {
        self.count += 1
        print(self.count)
    }
    
    func touchUpInsideMinus(sender: AnyObject) {
        self.count -= 1
        print(self.count)
    }

}

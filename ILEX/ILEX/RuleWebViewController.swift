//
//  RuleWebViewController.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/30.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

class RuleWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var targetURL = "http://itlife009.com/ILEX/rule/index.html"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAddressURL()
    }
    func loadAddressURL() {
        let requestURL = URL(string: self.targetURL)
        guard let url = requestURL else { return }
        let req = URLRequest(url: url)
        webView.loadRequest(req as URLRequest)
    }
}

//
//  UIViewControllerExtension.swift
//  ILEX
//
//  Created by 朴 基馥 on 2016/10/11.
//  Copyright © 2016年 ILEX. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, defaultHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: defaultHandler)
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: cancelHandler)
        alertController.addAction(cancelAction)
//        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func showAlert(_ title: String?, message: String?, defaultHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: defaultHandler)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

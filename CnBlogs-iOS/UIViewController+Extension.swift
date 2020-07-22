//
//  UIViewController+Extension.swift
//  CnBlogs-iOS
//
//  Created by Noah on 2020/7/22.
//  Copyright © 2020 rsenjoyer. All rights reserved.
//

import UIKit

extension UIViewController {

   @objc open func navWrapper() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

extension UINavigationController {
    @objc open override func navWrapper() -> UINavigationController {
        return self
    }
}

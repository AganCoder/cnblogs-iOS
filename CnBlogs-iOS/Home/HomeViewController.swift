//
//  HomeViewController.swift
//  CnBlogs-iOS
//
//  Created by Noah on 2020/7/22.
//  Copyright © 2020 rsenjoyer. All rights reserved.
//   

import UIKit

extension HomeViewController {

    static func make() -> HomeViewController {
        return HomeViewController()
    }
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let titleItem = self.navigationController?.navigationBar.topItem {
            titleItem.title = "首页"
        }
    }
    

}

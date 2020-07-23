//
//  CBBlogViewController.swift
//  Blog
//
//  Created by Noah-Normal on 2020/3/7.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import UIKit

class BaseViewController:  UIViewController {

    var homeType: HomeController.HomeType { fatalError("type not set") }

    var controller: AnyHomeController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

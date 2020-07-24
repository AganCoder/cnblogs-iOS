//
//  ComposeViewController.swift
//  CnBlogs-iOS
//
//  Created by Noah on 2020/7/22.
//  Copyright © 2020 rsenjoyer. All rights reserved.
//

import UIKit

extension ComposeViewController {
    static func make() -> ComposeViewController {
        return ComposeViewController()
    }
}


class ComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let titleItem = self.navigationController?.navigationBar.topItem {
            titleItem.title = "闪存"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

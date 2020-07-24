//
//  MainViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let home = HomeViewController.make().navWrapper()
        home.tabBarItem.title = "首页"
        
        let compose = ComposeViewController.make().navWrapper()
        compose.tabBarItem.title = "闪存"

        let problem = ProblemViewController.make().navWrapper()
        problem.tabBarItem.title = "博问"

        let mine = MineViewController.make().navWrapper()
        mine.tabBarItem.title = "我"

        setViewControllers([home, compose, problem, mine], animated: true)

    }
}

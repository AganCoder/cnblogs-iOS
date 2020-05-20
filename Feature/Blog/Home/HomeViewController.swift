//
//  BlogViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Common


enum HomeFeature: Feature {
    
    static var dependenciesInitializer: AnyInitializer {
        return AnyInitializer(Common.Empty.init)
    }
                
    static func build(dependencies: Common.Empty) -> UIViewController {
        return HomeViewController()
    }
}

public extension HomeViewController {
    
    static func make() -> HomeViewController {
        return HomeViewController()
    }
}

public class HomeViewController: UIViewController {
    
    var blogViewController: BlogViewController!
    
    var newsViewController: NewsViewController!
    
    var libraryViewController: LibraryViewController!
            
            
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        title = "博客"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        
    }
}

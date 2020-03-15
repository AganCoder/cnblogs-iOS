//
//  BlogViewController.swift
//  CnBlogs-iOS
//
//  Created by enjoy on 2019/11/3.
//  Copyright © 2019 rsenjoyer. All rights reserved.
//

import UIKit
import Common

enum BlogFeature: Feature {
    
    static var dependenciesInitializer: AnyInitializer {
        return AnyInitializer(Common.Empty.init)
    }
                
    static func build(dependencies: Common.Empty) -> UIViewController {
        return BlogViewController()
    }
}

public extension BlogViewController {
    static func make() -> BlogViewController {
        return BlogViewController()
    }
}

public class BlogViewController: UIViewController {

    var homeBlogViewController: CBBlogViewController?
    
    var recommendBlogViewController: RecommendViewController?
            
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        title = "博客"
    }
    
    
    
    
}

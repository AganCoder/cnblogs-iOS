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

    override public func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
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

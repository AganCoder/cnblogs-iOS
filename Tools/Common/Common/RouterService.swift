//
//  RouterService.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/10.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation
import UIKit

public protocol Dependency {}

public final class RouterService: Dependency {

    public static let shared = RouterService()
    
    var store = Store()

    public init() {
        register(dependency: self)
    }

    public func register(dependency: Dependency) {
        store.register(dependency)
    }
    
    func featureViewController<T: Feature>(forFeature: T.Type) -> UIViewController {
        let deps = T.dependenciesInitializer.build(store) as! T.Dependencies
        let viewController = T.build(dependencies: deps)
        return viewController
    }
    
    func navigate<T: Feature>(toFeature: T.Type, fromView viewController: UIViewController) {
        let viewController = featureViewController(forFeature: toFeature)
        viewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present<T: Feature>(toFeature: T.Type, fromView viewController: UIViewController) {
        let viewController = featureViewController(forFeature: toFeature)
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    
    
}

public final class Store {

    var dependencies = [String: Any]()

    func get<T>(_ dependencyType: T.Type) -> T {
        let name = String(describing: dependencyType)
        return dependencies[name] as! T
    }

    func register(_ dependency: Dependency) {
        let name = String(describing: type(of: dependency))
        dependencies[name] = dependency
    }
}

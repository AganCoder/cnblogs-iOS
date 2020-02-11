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

public struct Empty: Dependency {
    public init() { }
}

public final class RouterService: Dependency {

    public static let shared = RouterService()
    
    var store = Store()

    public init() {
        register(dependency: self)
        register(dependency: Empty())
    }

    public func register(dependency: Dependency) {
        store.register(dependency)
    }
    
    public func featureViewController<T: Feature>(forFeature: T.Type) -> UIViewController {
        let deps = T.dependenciesInitializer.build(store) as! T.Dependencies
        let viewController = T.build(dependencies: deps)
        return viewController
    }
    
    public func navigate<T: Feature>(toFeature: T.Type, fromView viewController: UIViewController) {
        let vc = featureViewController(forFeature: toFeature)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func present<T: Feature>(toFeature: T.Type, fromView viewController: UIViewController) {
        let vc = featureViewController(forFeature: toFeature)
        viewController.present(vc, animated: true, completion: nil)
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

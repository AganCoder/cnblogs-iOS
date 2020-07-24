//
//  AnyInitializer.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/10.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation

public final class AnyInitializer {

    public let build: (Store) -> Any
    
    public init<T>(_ function: @escaping () -> T) {
        build = { store in
            return function()
        }
    }

    public init<T: Dependency, U>(_ function: @escaping (T) -> U) {
        build = { store in
            let t: T = store.get(T.self)
            return function(t)
        }
    }

    public init<T: Dependency, U: Dependency, V>(_ function: @escaping (T, U) -> V) {
        build = { store in
            let t: T = store.get(T.self)
            let u: U = store.get(U.self)
            return function(t, u)
        }
    }

    public init<T: Dependency, U: Dependency, V: Dependency, W>(_ function: @escaping (T, U, V) -> W) {
        build = { store in
            let t: T = store.get(T.self)
            let u: U = store.get(U.self)
            let v: V = store.get(V.self)
            return function(t, u, v)
        }
    }
}

//
//  Freature.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/10.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation
import UIKit



public protocol Feature {
    
    associatedtype Dependencies
    static var dependenciesInitializer: AnyInitializer { get }
    static func build(dependencies: Dependencies) -> UIViewController
}

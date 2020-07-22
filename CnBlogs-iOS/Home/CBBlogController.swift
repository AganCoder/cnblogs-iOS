//
//  CBBlogController.swift
//  Blog
//
//  Created by Noah-Normal on 2020/3/7.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import UIKit

public enum HomeType: String, CaseIterable {
    case blog
    case news
    case library
}

extension HomeType: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

@available(iOS 13, *)
extension HomeType: Identifiable {
    
    public var id: String {
        return self.rawValue
    }
}



class CBHomeController: NSObject {
    
    fileprivate var blogs: [HomeType: AnyHomeController] = [:]
    
//    subscript(type: HomeType) -> AnyHomeController {
//
//
//    }
//
//    subscript(type: HomeType) -> AnyHomeController? {
//
//        let blogController: AnyHomeController?
//
//        repeat {
//            if blogs.keys.contains(type) {
//                break;
//            }
//
//            let controller: AnyHomeController
//
//            switch type {
//            case .home:
//                controller = HomeBlogController()
//            case .recommend:
//                controller = RecommendBlogController()
//            }
//            blogs[type] = controller
//
//        } while(false)
//
//        blogController = blogs[type]
//
//        return blogController
//    }
}

//
//extension CBBlogController {
//
//    public func blogOfIdentifier(_ identifier: String?) -> AnyHomeController? {
//        guard let blogType = HomeType(identifier: identifier) else { return nil }
//
//        return self[blogType]
//    }
//}

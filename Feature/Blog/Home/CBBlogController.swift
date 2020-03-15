//
//  CBBlogController.swift
//  Blog
//
//  Created by Noah-Normal on 2020/3/7.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import UIKit

public enum BlogType {
    case home
    case recommend
}

extension BlogType {
    
    public var identifier: String {
        switch self {
        case .home:
            return "Home"
        case .recommend:
            return "Recommend"
        }
    }
    
    public init?(identifier: String?) {
        guard let identifier = identifier else {return nil }
        
        switch identifier {
        case BlogType.home.identifier:
            self = .home
        case BlogType.recommend.identifier:
            self = .recommend
        default:
            return nil
        }
    }
}

extension BlogType: Hashable, Equatable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

public func == (lhs: BlogType, rhs: BlogType) -> Bool {
    switch (lhs, rhs) {
    case (.home, .home):
        return true
    case (.recommend, .recommend):
        return true
    default:
        return false
    }
}


class CBBlogController: NSObject {
    
    fileprivate var blogs: [BlogType: AnyBlogController] = [:]
    
    subscript(type: BlogType) -> AnyBlogController? {
        
        let blogController: AnyBlogController?
        
        repeat {
            if blogs.keys.contains(type) {
                break;
            }
            
            let controller: AnyBlogController
            
            switch type {
            case .home:
                controller = HomeBlogController()
            case .recommend:
                controller = RecommendBlogController()
            }
            blogs[type] = controller
            
        } while(false)
        
        blogController = blogs[type]
                
        return blogController
    }
}

extension CBBlogController {
    
    public func blogOfIdentifier(_ identifier: String?) -> AnyBlogController? {
        guard let blogType = BlogType(identifier: identifier) else { return nil }
        
        return self[blogType]
    }
}

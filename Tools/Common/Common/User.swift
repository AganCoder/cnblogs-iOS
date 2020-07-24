//
//  User.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/12.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation

public class User: NSObject {
    
    public var userName: String!
    
    public var userId: String!
    
    public var spaceUserId: String!
    
    public var blogId: String!
    
    public var displayName: String!
    
    public var face: String!
    
    public var avatar: String!
    
    public var seniority: String!
        
    public var blogApp: String!
    
    public var isGuest: Bool = true
    
    public var info: [String: Any] = [:]
    
    public static var token: Token?
}

extension User {
    
    var current: User? {
        
        return nil
    }
}

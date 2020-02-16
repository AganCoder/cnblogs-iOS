//
//  User.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/12.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation

// https://api.cnblogs.com/help#4e598eb53dda7bd5ed0291edd7155871


public class Token: NSObject {
    
    public var accessToken: String!
    
    public var tokenType: String!
    
    public var expiredDate: Date!
    
    public var refreshToken: String!
    
}

extension Token {
    
    public var isExpired: Bool {
        return true
    }
}
 

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
    
    public var token: Token?
}

extension User {
    
    var current: User? {
        return nil
    }
}

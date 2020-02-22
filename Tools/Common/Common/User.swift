//
//  User.swift
//  Common
//
//  Created by Noah-Normal on 2020/2/12.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation

// https://api.cnblogs.com/help#4e598eb53dda7bd5ed0291edd7155871



public struct Token {
    
    public var accessToken: String?
    
    public var tokenType: String?
    
    public var expiresIn: Date?
    
    public var refreshToken: String?
}

extension Token: Codable {
    public enum CodingKeys : String, CodingKey {
        case accessToken
        case tokenType
        case expiresIn
        case refreshToken
    }
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.accessToken = try? container?.decode(String.self, forKey: .accessToken)
        self.tokenType = try? container?.decode(String.self, forKey: .tokenType)
        self.refreshToken = try? container?.decode(String.self, forKey: .refreshToken)
        self.expiresIn = try? container?.decode(Date.self, forKey: .expiresIn)
    }
    
    public func encode(to encoder: Encoder) throws {
        debugPrint(#function)
    }
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
    
    public static var token: Token?
}

extension User {
    
    var current: User? {
        
        return nil
    }
}

//
//  Token.swift
//  Common
//
//  Created by Noah on 2020/6/5.
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
extension Token {

    public var isExpired: Bool {
        guard let expiresIn = self.expiresIn else {
            return true
        }
        return expiresIn < Date()
    }
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
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(self.accessToken, forKey: .accessToken)
        try? container.encode(self.tokenType, forKey: .tokenType)
        try? container.encode(self.refreshToken, forKey: .refreshToken)
        try? container.encode(self.expiresIn, forKey: .expiresIn)
    }
}

extension Token: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return self.debugDescription
    }

    public var debugDescription: String {
        let accessToken = self.accessToken ?? ""
        let tokenType   = self.tokenType ?? ""
        let refreshToken = self.refreshToken ?? ""
        let expiresIn   = self.expiresIn ?? Date()

        return "accessToken: \(accessToken), tokenType: \(tokenType), refreshToken: \(refreshToken), expiresIn: \(expiresIn)"
    }
}

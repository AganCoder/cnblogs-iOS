//
//  DefaultStorage.swift
//  Common
//
//  Created by Noah on 2020/6/5.
//  Copyright © 2020 Noah-Normal. All rights reserved.
//

import Foundation

public protocol DefaultsStorage {

    @discardableResult
    func saveDefaults(from rep: PropertyListRepresentable) -> Bool

    @discardableResult
    func loadDefaults(to rep: PropertyListRepresentable) -> Bool

    @discardableResult
    func clearDefaults(of rep: PropertyListRepresentable) -> Bool
}

public class UserDefatulsStorage: DefaultsStorage {

    private let suitesName: String?

    public init(suitsName: String? = nil) {

        self.suitesName = suitsName
    }

    public func saveDefaults(from rep: PropertyListRepresentable) -> Bool {

        guard let identifier = rep.preferredIdentifier,
            let userDefaults = UserDefaults(suiteName: self.suitesName)
            else { return false }

        userDefaults.set(rep.propertyListDictionary, forKey: identifier)
        userDefaults.synchronize()

        return true
    }

    public func loadDefaults(to rep: PropertyListRepresentable) -> Bool {

        guard let identifier = rep.preferredIdentifier,
            let userDefaults = UserDefaults(suiteName: self.suitesName),
            let dictionary = userDefaults.object(forKey: identifier) as? [String: Any]
            else { return false }

        return rep.from(propertyListDictionary: dictionary)
    }

    public func clearDefaults(of rep: PropertyListRepresentable) -> Bool {

        guard let identifier = rep.preferredIdentifier,
            let userDefaults = UserDefaults(suiteName: self.suitesName)
            else { return false }

        userDefaults.set(nil, forKey: identifier)
        userDefaults.synchronize()

        return true
    }

}

public protocol PropertyListRepresentable: class {

    func from(propertyListDictionary: [String: Any]) -> Bool

    var propertyListDictionary: [String: Any] { get }

    var preferredIdentifier: String? { get }
}


//
//  UserDefaultsStore.swift
//  Storage
//
//  Created by Vyacheslav Razumeenko on 14.11.2024.
//

import Foundation

public final class UserDefaultsStore: StoreProtocol {
    public typealias Keys = StoreKeys

    public init() {}

    private let userDefaults = UserDefaults.standard

    public func get<T>(_ key: StoreKeys) -> T? where T: Decodable {
        do {
            guard let data = userDefaults.object(forKey: key.rawValue) as? Data else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    public func set<T>(_ value: T?, key: StoreKeys) where T: Encodable {
        guard let value = value else {
            userDefaults.set(nil, forKey: key.rawValue)
            return
        }

        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch let error {
            debugPrint("‼️ Error set to 👮🏻‍♂️: \(error.localizedDescription)")
        }
    }

    public func remove(key: StoreKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }

    public func clear() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
        userDefaults.synchronize()
    }
}

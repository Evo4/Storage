//
//  KeychainStore.swift
//  Storage
//
//  Created by Vyacheslav Razumeenko on 14.11.2024.
//

import Foundation
import KeychainAccess

public final class KeychainStore: StoreProtocol {
    public typealias Keys = StoreKeys

    public init() {}

    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    public func get<T>(_ key: StoreKeys) -> T? where T: Decodable {
        do {
            guard let data = try keychain.getData(key.rawValue) else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint("‼️ Error get value 🔑: \(error.localizedDescription)")
            return nil
        }
    }

    public func set<T>(_ value: T?, key: StoreKeys) where T: Encodable {
        guard let value = value else { return }

        do {
            let data = try JSONEncoder().encode(value)

            try keychain.set(data, key: key.rawValue)
        } catch let error {
            debugPrint("‼️ Error set to 🔑: \(error.localizedDescription)")
        }
    }

    public func remove(key: StoreKeys) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            debugPrint("‼️ Error remove from 🔑: \(error.localizedDescription)")
        }
    }

    public func clear() {
        do {
            try keychain.removeAll()
        } catch let error {
            debugPrint("‼️ Error remove all 🔑: \(error.localizedDescription)")
        }
    }
}

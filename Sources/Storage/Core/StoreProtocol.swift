//
//  StoreProtocol.swift
//  Storage
//
//  Created by Vyacheslav Razumeenko on 14.11.2024.
//

public protocol StoreProtocol: AnyObject {
    associatedtype Keys

    func get<T: Decodable>(_ key: Keys) -> T?
    func set<T: Encodable>(_ value: T?, key: Keys)
    func remove(key: Keys)
    func clear()
}

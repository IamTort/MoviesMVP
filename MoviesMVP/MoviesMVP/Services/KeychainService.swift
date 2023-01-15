// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import KeychainAccess

final class KeychainService: KeychainServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let keychainServiceString = "ru.MoviesMVP"
    }

    // MARK: - Public property

    private let keychain = Keychain(service: Constants.keychainServiceString)

    // MARK: - Public methods

    func setAPIKey(_ value: String, forKey: String) {
        keychain[forKey] = value
    }

    func getAPIKey(_ key: String) -> String {
        guard let keyValue = keychain[key] else { return String() }
        return keyValue
    }
}

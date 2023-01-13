// KeychainService.swift
// Copyright © RoadMap. All rights reserved.

import KeychainAccess

final class KeychainService {
    // MARK: - Private Enum

    private enum Constants {
        static let apiValueString = "a5b0bb6ebe58602d88ccf2463076122b"
        static let apiKeyString = "apiKey"
        static let keychainServiceString = "ru.MoviesMVP"
    }

    // MARK: - Public property

    static let shared = KeychainService()

    // MARK: - Initializer

    private init() {}

    // MARK: - Public methods

    func setAPIKey() {
        let keychain = Keychain(service: Constants.keychainServiceString)
        keychain[Constants.apiKeyString] = Constants.apiValueString
    }

    func getAPIKey() -> String {
        guard let keychainString = Keychain(service: Constants.keychainServiceString)[Constants.apiKeyString] else {
            setAPIKey()
            return getAPIKey()
        }
        return keychainString
    }
}

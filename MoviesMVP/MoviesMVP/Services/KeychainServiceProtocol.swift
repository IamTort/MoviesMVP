// KeychainServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol KeychainServiceProtocol {
    func setAPIKey(_ value: String, forKey: String)
    func getAPIKey(_ key: String) -> String
}

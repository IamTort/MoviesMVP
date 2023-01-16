// MockImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import XCTest

/// Мок сервиса по загрузке картинок
final class MockImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public Methods

    func fetchData(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {}
}

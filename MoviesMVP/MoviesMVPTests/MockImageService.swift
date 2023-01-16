// MockImageService.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import XCTest

/// Мок сервиса загрузки фото
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {}
}

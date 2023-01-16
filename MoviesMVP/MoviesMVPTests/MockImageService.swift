// MockImageService.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockImageService.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import XCTest

/// Мок сервиса загрузки фото
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public Methods

    func fetchImage(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {}
}

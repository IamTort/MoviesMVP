// MockMainView.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockMainView.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import XCTest

/// Mок вью
final class MockMainView: MainViewProtocol {
    // MARK: - Public Methods

    func failure(error: Error) {}

    func reloadTableView() {}

    func scrollToTop() {}
}

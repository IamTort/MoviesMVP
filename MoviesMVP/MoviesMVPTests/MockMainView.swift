// MockMainView.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import XCTest

/// Mок вью
final class MockMainView: MainViewProtocol {
    // MARK: - Public Methods

    func failure(error: Error) {}

    func reloadTableView() {}

    func scrollToTop() {}
}

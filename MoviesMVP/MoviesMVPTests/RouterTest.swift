// RouterTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import XCTest

/// Тесты переходов между экранами
final class RouterTest: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let filmId = 3454
        static let videoIndex = 45827
    }

    // MARK: - Public property

    let assembly = MockAssemblyBuilder()
    var router: RouterProtocol?
    var navigationController = MockNavigationController()

    // MARK: - Public Methods

    override func setUp() {
        router = MockRouter(assemblyBuilder: assembly, navigationController: navigationController)
    }

    override func tearDown() {
        router = nil
    }

    func testRouter() {
        router?.showDetail(filmId: Constants.filmId)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is FilmViewController)
    }

    func testRouterToWeb() {
        router?.showVideo(videoIndex: Constants.videoIndex)
        let webViewController = navigationController.presentedVC
        XCTAssertTrue(webViewController is WebViewController)
    }
}

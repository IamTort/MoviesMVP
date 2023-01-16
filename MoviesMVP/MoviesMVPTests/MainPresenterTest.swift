// MainPresenterTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import RealmSwift
import SwiftyJSON
import XCTest

/// Тесты презентера главного экрана
final class MainPresenterTest: XCTestCase {
    // MARK: - Public property

    let assemblyBuilder = MockAssemblyBuilder()
    var testTarget: MainViewPresenterProtocol!
    var networkService: NetworkServiceProtocol!
    var mainView: MainViewProtocol!
    var imageService: ImageServiceProtocol!
    var realmService: RealmServiceProtocol!
    var routerService: MockRouter!
    var navigationController = MockNavigationController()

    // MARK: - Public methods

    override func setUpWithError() throws {
        networkService = MockNetworkService()
        mainView = MockMainView()
        routerService = MockRouter(assemblyBuilder: assemblyBuilder, navigationController: navigationController)
        imageService = MockImageService()
        realmService = MockRealmService()

        testTarget = MainPresenter(
            view: mainView,
            networkService: networkService,
            router: routerService,
            imageService: imageService,
            realmService: realmService
        )
    }

    override func tearDownWithError() throws {}

    func testFetchMovies() {
        testTarget.fetchMovies()
        sleep(UInt32(1))
        XCTAssertTrue(testTarget.movies.count != 0)
    }

    func testFetchNextMovies() {
        testTarget.fetchNextMovies()
        sleep(UInt32(1))
        XCTAssertTrue(testTarget.movies.count != 0)
    }

    func testNext() {
        testTarget.tapOnFilm(filmId: 1)
        XCTAssertTrue(routerService.isDetailShowed)
    }

    func testUpdateMoviesCategory() {
        testTarget.updateMoviesCategory(sender: 1)
        sleep(UInt32(1))
        XCTAssertTrue(testTarget.movies[0].movieType == PurchaseEndPoint.topRated.rawValue)
    }
}

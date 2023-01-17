// ImageAPIServiceTest.swift
// Copyright © RoadMap. All rights reserved.

@testable import MoviesMVP
import XCTest

/// Тесты сервиса по загрузке картинок
final class ImageAPIServiceTest: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let iconString = "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg"
        static let filmsString = "Фильмы"
        static let topCategoryString = "Топ"
        static let upcomingCategoryString = "Скоро"
        static let secondFilmString = "Гнев во спасение"
        static let popularCategoryString = "Популярное"
    }

    // MARK: - Public property

    var imageAPIService: ImageAPIServiceProtocol?
    var imageData: Data?

    // MARK: - Public methods

    override func setUp() {
        imageAPIService = MockImageAPIService()
    }

    override func tearDown() {
        imageAPIService = nil
    }

    func testFetchData() {
        let iconUrl = "\(PurchaseEndPoint.link.rawValue)\(Constants.iconString)"
        imageAPIService?.fetchData(byUrl: iconUrl, completion: { result in
            switch result {
            case let .success(data):
                self.imageData = data
                XCTAssertNotNil(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}

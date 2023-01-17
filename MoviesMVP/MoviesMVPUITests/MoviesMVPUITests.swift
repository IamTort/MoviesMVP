// MoviesMVPUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

/// Тесты UI
final class MoviesMVPUITests: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let avatarFilmString = "Аватар: Путь воды"
        static let filmsString = "Фильмы"
        static let topCategoryString = "Топ"
        static let upcomingCategoryString = "Скоро"
        static let secondFilmString = "Гнев во спасение"
        static let popularCategoryString = "Популярное"
    }

    // MARK: - Public methods

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier: Constants.avatarFilmString).element.tap()
        let navBar = app.navigationBars.buttons[Constants.filmsString]
        navBar.tap()
        app.buttons[Constants.topCategoryString].tap()
        app.swipeDown()
        app.swipeUp()
        app.buttons[Constants.upcomingCategoryString].tap()
        app.swipeUp()
        app.swipeDown()
        tablesQuery.cells.containing(.staticText, identifier: Constants.secondFilmString).element.tap()
        app.swipeUp()
        navBar.tap()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.buttons[Constants.popularCategoryString].tap()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

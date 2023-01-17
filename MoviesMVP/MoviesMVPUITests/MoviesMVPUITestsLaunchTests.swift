// MoviesMVPUITestsLaunchTests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

/// Тесты входа в приложение
final class MoviesMVPUITestsLaunchTests: XCTestCase {
    // MARK: - Private Enum

    private enum Constants {
        static let launchScreenString = "Launch Screen"
    }

    // MARK: - Public methods

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.launchScreenString
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

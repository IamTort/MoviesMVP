// MockNavigationController.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockNavigationController.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import XCTest

/// Мок контроллера навигации
final class MockNavigationController: UINavigationController {
    // MARK: - Public property

    var presentedVC: UIViewController?

    // MARK: - Public Methods

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

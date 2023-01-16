// MockRouter.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockRouter.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import XCTest

/// Мок роутера
final class MockRouter: RouterProtocol {
    // MARK: - Public property

    public var isDetailShowed: Bool = false
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializer

    init(assemblyBuilder: AssemblyBuilderProtocol, navigationController: UINavigationController) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    func initialViewController() {}
    func showDetail(filmId: Int) {
        isDetailShowed = true
    }

    func showVideo(videoIndex: Int) {}

    func popToRoot() {}
}

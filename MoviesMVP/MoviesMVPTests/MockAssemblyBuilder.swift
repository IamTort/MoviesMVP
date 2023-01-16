// MockAssemblyBuilder.swift
// Copyright © RoadMap. All rights reserved.

//
//  MockAssemblyBuilder.swift
//  MoviesMVPTests
//
//  Created by angelina on 16.01.2023.
//
@testable import MoviesMVP
import XCTest

/// Мок сборщика модулей
final class MockAssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func makeMainModule(router: RouterProtocol) -> UIViewController {
        MoviesViewController()
    }

    func makeDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        FilmViewController()
    }

    func makeWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        UIViewController()
    }
}

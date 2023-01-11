// AssemblyBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Строитель  контроллеров
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public methods

    func makeMainModule(router: RouterProtocol) -> UIViewController {
        let view = MoviesViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    func makeDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        let view = FilmViewController()
        let networkService = NetworkService()
        let presenter = FilmPresenter(view: view, networkService: networkService, filmIndex: filmIndex, router: router)
        view.presenter = presenter
        return view
    }

    func makeWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        let view = WebViewController()
        let networkService = NetworkService()
        let presenter = WebPresenter(view: view, networkService: networkService, filmIndex: filmIndex, router: router)
        view.presenter = presenter
        return view
    }
}

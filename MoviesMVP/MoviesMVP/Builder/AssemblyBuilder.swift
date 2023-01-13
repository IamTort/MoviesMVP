// AssemblyBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модулей
final class AssemblyBuilder: AssemblyBuilderProtocol {
    // MARK: - Public methods

    func makeMainModule(router: RouterProtocol) -> UIViewController {
        let view = MoviesViewController()
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        let imageService = ImageService()
        let realmService = RealmService()
        let presenter = MainPresenter(
            view: view,
            networkService: networkService,
            router: router,
            imageService: imageService,
            realmService: realmService
        )
        view.presenter = presenter
        return view
    }

    func makeDetailModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        let view = FilmViewController()
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        let realmService = RealmService()
        let imageService = ImageService()
        let presenter = MoviePresenter(
            view: view,
            networkService: networkService,
            filmIndex: filmIndex,
            router: router,
            imageService: imageService,
            realmService: realmService
        )
        view.presenter = presenter
        return view
    }

    func makeWebModule(filmIndex: Int, router: RouterProtocol) -> UIViewController {
        let view = WebViewController()
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        let presenter = WebPresenter(view: view, networkService: networkService, filmIndex: filmIndex, router: router)
        view.presenter = presenter
        return view
    }
}

// Router.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Роутер
final class Router: RouterProtocol {
    // MARK: - Public property

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializer

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public methods

    func initialViewController() {
        guard let navigationController = navigationController,
              let mainViewController = assemblyBuilder?.makeMainModule(router: self) else { return }
        navigationController.viewControllers = [mainViewController]
    }

    func showDetail(filmId: Int) {
        guard let filmViewController = assemblyBuilder?.makeDetailModule(filmIndex: filmId, router: self),
              let navigationController = navigationController else { return }
        navigationController.pushViewController(filmViewController, animated: true)
    }

    func showVideo(videoIndex: Int) {
        if let navigationController = navigationController {
            guard let filmViewController = assemblyBuilder?.makeWebModule(filmIndex: videoIndex, router: self)
            else { return }
            navigationController.pushViewController(filmViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

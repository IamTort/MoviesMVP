// FilmPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана Фильма
final class FilmPresenter: FilmViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let alertTitleString = "Ошибка"
        static let alertMessageString = "Ошибка на сервере"
    }

    // MARK: - Public property

    var filmInfo: Film?

    // MARK: - Private property

    private let networkService: NetworkServiceProtocol?
    private var router: RouterProtocol?
    private weak var view: FilmViewProtocol?

    // MARK: - Initializer

    required init(
        view: FilmViewProtocol,
        networkService: NetworkServiceProtocol,
        filmIndex: Int,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getFilm(index: filmIndex)
    }

    // MARK: - Public method

    func tapLoadVideo(videoIndex: Int) {
        router?.showVideo(videoIndex: videoIndex)
    }

    // MARK: - Private method
    
    private func getFilm(index: Int) {
        networkService?.loadFilm(index: index) { [weak self] result in
            guard let self = self,
                  let networkService = self.networkService else { return }
            switch result {
            case let .success(film):
                self.filmInfo = film
                self.view?.setupData(data: film, networkService: networkService)
            case .failure:
                self.view?.showAlert(title: Constants.alertTitleString, message: Constants.alertMessageString)
            }
        }
    }
}

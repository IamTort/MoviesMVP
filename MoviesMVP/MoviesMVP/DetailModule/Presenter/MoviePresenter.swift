// MoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана Фильма
final class MoviePresenter: MovieViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let alertTitleString = "Ошибка"
        static let alertMessageString = "Ошибка на сервере"
    }

    // MARK: - Public property

    var movie: MovieDetail?

    // MARK: - Private property

    private let networkService: NetworkServiceProtocol?
    private var filmIndex: Int?
    private var router: RouterProtocol?
    private weak var view: FilmViewProtocol?

    // MARK: - Initializer

    init(
        view: FilmViewProtocol,
        networkService: NetworkServiceProtocol,
        filmIndex: Int,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.filmIndex = filmIndex
    }

    // MARK: - Public method

    func tapLoadVideo(videoIndex: Int) {
        router?.showVideo(videoIndex: videoIndex)
    }

    // MARK: - Private method

    func fetchMovie() {
        guard let index = filmIndex else { return }
        networkService?.fetchMovie(index: index) { [weak self] result in
            guard let self = self,
                  let networkService = self.networkService else { return }
            switch result {
            case let .success(movie):
                self.movie = movie
                self.view?.setupData(data: movie, networkService: networkService)
            case .failure:
                self.view?.showAlert(title: Constants.alertTitleString, message: Constants.alertMessageString)
            }
        }
    }
}

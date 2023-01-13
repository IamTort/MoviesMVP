// MoviePresenter.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Презентер экрана Фильма
final class MoviePresenter: MovieViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let alertTitleString = "Ошибка"
        static let alertMessageString = "Ошибка на сервере"
    }

    // MARK: - Public property

    var film: Results<MovieDetail>?
    var movie: MovieDetail?

    // MARK: - Private property

    private let networkService: NetworkServiceProtocol?
    private var imageService: ImageServiceProtocol?
    private var realmService: RealmServiceProtocol
    private var filmIndex: Int?
    private var router: RouterProtocol?
    private weak var view: FilmViewProtocol?

    // MARK: - Initializer

    init(
        view: FilmViewProtocol,
        networkService: NetworkServiceProtocol,
        filmIndex: Int,
        router: RouterProtocol,
        imageService: ImageServiceProtocol,
        realmService: RealmServiceProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.filmIndex = filmIndex
        self.imageService = imageService
        self.realmService = realmService
    }

    // MARK: - Public method

    func tapLoadVideo(videoIndex: Int) {
        router?.showVideo(videoIndex: videoIndex)
    }

    // MARK: - Public method

    func fetchMovie() {
        guard let index = filmIndex else { return }
        networkService?.fetchMovie(index: index) { [weak self] result in
            guard let self = self,
                  let imageService = self.imageService else { return }
            switch result {
            case let .success(movie):
                self.realmService.save(movies: [movie], update: true)
                self.loadRealmData()
                self.view?.setupData(data: movie, imageService: imageService)
            case .failure:
                self.view?.showAlert(title: Constants.alertTitleString, message: Constants.alertMessageString)
            }
        }
    }

    func loadRealmData() {
        guard let id = filmIndex,
              let detailsRealm = realmService.loadData(movies: MovieDetail.self, id: id) else { return }
        movie = detailsRealm
    }
}

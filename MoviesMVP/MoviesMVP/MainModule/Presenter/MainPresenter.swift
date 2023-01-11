// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер экрана Фильмов
final class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let apiValueString = "a5b0bb6ebe58602d88ccf2463076122b"
        static let apiKeyString = "apiKey"
    }

    // MARK: - Public property

    var networkService: NetworkServiceProtocol?
    var movies: [Movies]?
    var moviesPageInfo: Int?

    // MARK: - Private property

    private var router: RouterProtocol?
    private var page = 1
    private weak var view: MainViewProtocol?

    // MARK: - Initializer

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        fetchMovies()
    }

    // MARK: - Public methods

    func tapOnTheFilm(filmId: Int) {
        router?.showDetail(filmId: filmId)
    }

    func fetchMovies() {
        UserDefaults.standard.set(Constants.apiValueString, forKey: Constants.apiKeyString)
        networkService?.fetchFilms(page: 1, api: PurchaseEndPoint.popular) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else {
                    return
                }
                self.movies = movies
                self.moviesPageInfo = movies.first?.pageCount
                self.view?.reloadTableView()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func updateFilmsCategory(sender: Int) {
        var category: PurchaseEndPoint {
            switch sender {
            case 0: return .popular
            case 1: return .topRated
            case 2: return .upcoming
            default: return .popular
            }
        }

        networkService?.fetchFilms(page: 1, api: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.moviesPageInfo = movies?.first?.pageCount
                self.movies = movies
                self.view?.scrollToTop()
                self.view?.reloadTableView()

            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func fetchNextMovies() {
        guard let pageInfo = moviesPageInfo,
              page < pageInfo else { return }
        page += 1
        fetchMovies(page: page)
        view?.reloadTableView()
    }

    // MARK: - Private methods

    private func fetchMovies(page: Int) {
        networkService?.fetchFilms(page: page) { [weak self] result in
            guard let self = self,
                  var films = self.movies else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else { return }
                films += movies
                self.moviesPageInfo = movies.first?.pageCount
                self.view?.reloadTableView()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }
}

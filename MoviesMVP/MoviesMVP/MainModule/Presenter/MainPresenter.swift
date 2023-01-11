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

    var movies: [Movies]?
    var pageInfo: Int?

    // MARK: - Private property

    private let networkService: NetworkServiceProtocol?
    private var router: RouterProtocol?
    private var page = 1
    private weak var view: MainViewProtocol?

    // MARK: - Initializer

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getMovies()
    }

    // MARK: - Public methods

    func tapOnTheFilm(filmId: Int) {
        router?.showDetail(filmId: filmId)
    }

    func getMovies() {
        UserDefaults.standard.set(Constants.apiValueString, forKey: Constants.apiKeyString)
        networkService?.loadFilms(page: 1, api: PurchaseEndPoint.popular) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else {
                    return
                }
                self.movies = movies
                self.pageInfo = movies.first?.pageCount
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

        networkService?.loadFilms(page: 1, api: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.pageInfo = movies?.first?.pageCount
                self.movies = movies
                self.view?.scrollToTop()
                self.view?.reloadTableView()

            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func fetchNextMovies() {
        guard let pageInfo = pageInfo,
              page < pageInfo else { return }
        page += 1
        loadMore(page: page)
        view?.reloadTableView()
    }

    // MARK: - Private methods

    private func loadMore(page: Int) {
        networkService?.loadFilms(page: page) { [weak self] result in
            guard let self = self,
                  var films = self.movies else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else { return }
                films += movies
                self.pageInfo = movies.first?.pageCount
                self.view?.reloadTableView()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }
}

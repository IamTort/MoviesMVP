// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainAccess
import RealmSwift

/// Презентер экрана Фильмов
final class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let apiValueString = "a5b0bb6ebe58602d88ccf2463076122b"
        static let apiKeyString = "apiKey"
        static let keychainServiceString = "ru.MoviesMVP"
        static let firstPageNumber = 1
    }

    // MARK: - Public property

    var networkService: NetworkServiceProtocol?
    var imageService: ImageServiceProtocol?
    var realmService: RealmServiceProtocol
    var movies: [Movie] = []
    var moviesPageInfo: Int?

    // MARK: - Private property

    private var router: RouterProtocol?
    private var page = 1
    private var category = PurchaseEndPoint.popular
    private weak var view: MainViewProtocol?

    // MARK: - Initializer

    init(
        view: MainViewProtocol,
        networkService: NetworkServiceProtocol,
        router: RouterProtocol,
        imageService: ImageServiceProtocol,
        realmService: RealmServiceProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.imageService = imageService
        self.realmService = realmService
        fetchMovies()
    }

    // MARK: - Public methods

    func tapOnFilm(filmId: Int) {
        router?.showDetail(filmId: filmId)
    }

    func fetchMovies() {
        networkService?
            .fetchMovies(page: Constants.firstPageNumber, api: PurchaseEndPoint.popular) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(movies):
                    guard let movies = movies else {
                        return
                    }
                    movies.forEach { movie in
                        movie.movieType = PurchaseEndPoint.popular.rawValue
                    }
                    self.realmService.save(movies: movies, update: true)
                    self.loadRealmData()
                    self.moviesPageInfo = movies.first?.pageCount
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
    }

    func fetchMovies(page: Int) {
        networkService?.fetchMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else { return }
                movies.forEach { movie in
                    movie.movieType = self.category.rawValue
                }
                self.realmService.save(movies: movies, update: true)
                self.loadRealmData()
                self.moviesPageInfo = movies.first?.pageCount
                self.view?.reloadTableView()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func loadRealmData() {
        guard let moviesArray = realmService
            .loadData(movies: Movie.self, movieType: category.rawValue) else { return }
        movies = Array(moviesArray)
    }

    func updateMoviesCategory(sender: Int) {
        var category: PurchaseEndPoint {
            switch sender {
            case 0:
                return .popular
            case 1:
                return .topRated
            case 2:
                return .upcoming
            default:
                return .popular
            }
        }
        self.category = category
        fetch(api: category)
    }

    func fetch(api: PurchaseEndPoint) {
        networkService?.fetchMovies(page: Constants.firstPageNumber, api: api) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                movies?.forEach { movie in
                    movie.movieType = api.rawValue
                }
                guard let films = movies else { return }
                self.realmService.save(movies: films, update: true)
                self.loadRealmData()
                self.moviesPageInfo = movies?.first?.pageCount
                self.view?.scrollToTop()
                self.view?.reloadTableView()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }
}

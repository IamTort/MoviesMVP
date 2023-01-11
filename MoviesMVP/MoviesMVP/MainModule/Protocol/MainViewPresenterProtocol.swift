// MainViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильмов
protocol MainViewPresenterProtocol: AnyObject {
    var movies: [Movies]? { get set }
    var pageInfo: Int? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getMovies()
    func updateFilmsCategory(sender: Int)
    func fetchNextMovies()
    func tapOnTheFilm(filmId: Int)
}

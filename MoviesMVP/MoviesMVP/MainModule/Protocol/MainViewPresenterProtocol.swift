// MainViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильмов
protocol MainViewPresenterProtocol: AnyObject {
    var networkService: NetworkServiceProtocol? { get set }
    var movies: [Movies]? { get set }
    var moviesPageInfo: Int? { get set }
    func fetchMovies()
    func updateFilmsCategory(sender: Int)
    func fetchNextMovies()
    func tapOnFilm(filmId: Int)
}

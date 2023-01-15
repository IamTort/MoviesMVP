// MainViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильмов
protocol MainViewPresenterProtocol: AnyObject {
    var networkService: NetworkServiceProtocol? { get set }
    var imageService: ImageServiceProtocol? { get set }
    var movies: [Movie] { get set }
    var moviesPageInfo: Int? { get set }
    func fetchMovies()
    func updateMoviesCategory(sender: Int)
    func fetchNextMovies()
    func tapOnFilm(filmId: Int)
}

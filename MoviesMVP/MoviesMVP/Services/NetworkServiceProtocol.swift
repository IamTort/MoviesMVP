// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    func fetchMovies(page: Int, completion: @escaping (Result<[Movie]?, Error>) -> Void)
    func fetchMovies(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movie]?, Error>) -> Void)
    func fetchMovie(index: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
    func fetchVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void)
}

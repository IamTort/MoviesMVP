// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    func loadFilms(page: Int, completion: @escaping (Result<[Movies]?, Error>) -> Void)
    func loadFilms(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movies]?, Error>) -> Void)
    func loadFilm(index: Int, completion: @escaping (Result<Film, Error>) -> Void)
    func loadVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void)
}

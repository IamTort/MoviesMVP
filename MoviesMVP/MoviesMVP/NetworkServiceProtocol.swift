// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    func fetchFilms(page: Int, completion: @escaping (Result<[Movies]?, Error>) -> Void)
    func fetchFilms(page: Int, api: PurchaseEndPoint, completion: @escaping (Result<[Movies]?, Error>) -> Void)
    func fetchFilm(index: Int, completion: @escaping (Result<Film, Error>) -> Void)
    func fetchVideos(index: Int, completion: @escaping (Result<[VideoId], Error>) -> Void)
    func fetchData(iconUrl: String, completion: @escaping (Data) -> Void)
}

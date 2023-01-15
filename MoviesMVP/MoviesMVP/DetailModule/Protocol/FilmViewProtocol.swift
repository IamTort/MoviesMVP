// FilmViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана Фильма
protocol FilmViewProtocol: AnyObject {
    func fetchImage(pathString: String, imageService: ImageServiceProtocol)
    func setupData(data: MovieDetail, imageService: ImageServiceProtocol)
    func showAlert(title: String, message: String)
}

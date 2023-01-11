// RouterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Роутер экрана Фильмов
protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func showDetail(filmId: Int)
    func showVideo(videoIndex: Int)
    func popToRoot()
}

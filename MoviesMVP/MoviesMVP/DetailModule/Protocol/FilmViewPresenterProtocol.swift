// FilmViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильма
protocol FilmViewPresenterProtocol: AnyObject {
    var filmInfo: Film? { get set }
    init(view: FilmViewProtocol, networkService: NetworkServiceProtocol, filmIndex: Int, router: RouterProtocol)
    func tapLoadVideo(videoIndex: Int)
}

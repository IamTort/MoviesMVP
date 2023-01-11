// FilmViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильма
protocol FilmViewPresenterProtocol: AnyObject {
    var filmInfo: Film? { get set }
    func tapLoadVideo(videoIndex: Int)
}

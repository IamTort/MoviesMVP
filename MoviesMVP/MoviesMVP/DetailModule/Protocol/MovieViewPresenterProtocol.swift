// MovieViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана Фильма
protocol MovieViewPresenterProtocol: AnyObject {
    var movie: MovieDetail? { get set }
    func fetchMovie()
    func tapLoadVideo(videoIndex: Int)
}

// FilmViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана Фильма
protocol FilmViewProtocol: AnyObject {
    func setupData(data: Film)
    func showAlert(title: String, message: String)
}

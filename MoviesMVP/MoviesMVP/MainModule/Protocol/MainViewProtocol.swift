// MainViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана Фильмов
protocol MainViewProtocol: AnyObject {
    func failure(error: Error)
    func reloadTableView()
    func scrollToTop()
}

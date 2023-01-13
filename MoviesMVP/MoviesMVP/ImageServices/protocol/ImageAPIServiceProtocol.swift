// ImageAPIServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса загрузки фото с сети
protocol ImageAPIServiceProtocol {
    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ())
}

// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сервиса загрузки фото
protocol ImageServiceProtocol {
    func getPhoto(byUrl url: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

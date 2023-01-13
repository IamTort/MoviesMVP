// ProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол прокси
protocol ProxyProtocol {
    func loadImage(by url: String, completion: @escaping (Result<UIImage, Error>) -> ())
}

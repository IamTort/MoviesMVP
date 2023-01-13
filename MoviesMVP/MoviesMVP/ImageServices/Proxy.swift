// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Прокси
final class Proxy: ProxyProtocol {
    // MARK: - Public property

    let imageAPIService: ImageAPIServiceProtocol
    let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializer

    init(imageNetworkService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageNetworkService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public methods

    func loadImage(by url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageAPIService.loadPhoto(byUrl: url) { result in
                switch result {
                case let .success(data):
                    self.fileManagerService.saveImageToCache(url: url, data: data)
                    guard let image = UIImage(data: data) else { return }
                    completion(.success(image))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}

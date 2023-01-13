// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис загрузки фото
final class ImageService: ImageServiceProtocol {
    // MARK: - Public property

    let imageNetworkService = ImageAPIService()
    let fileManagerService = FileManagerService()

    // MARK: - Public methods

    func getPhoto(byUrl url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let proxy = Proxy(imageNetworkService: imageNetworkService, fileManagerService: fileManagerService)
        proxy.loadImage(by: url) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

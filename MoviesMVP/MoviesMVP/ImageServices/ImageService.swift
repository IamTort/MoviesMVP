// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис загрузки фото
final class ImageService: ImageServiceProtocol {
    // MARK: - Public property

    let imageNetworkService = ImageAPIService()
    let fileManagerService = FileManagerService()

    // MARK: - Public methods

    func fetchImage(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        let proxy = Proxy(imageNetworkService: imageNetworkService, fileManagerService: fileManagerService)
        proxy.loadImage(by: url) { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

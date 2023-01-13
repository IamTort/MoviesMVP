// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Загрузка фото с сети
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public methods

    func fetchData(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

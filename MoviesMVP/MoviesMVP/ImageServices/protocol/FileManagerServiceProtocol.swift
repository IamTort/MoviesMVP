// FileManagerServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сервиса загрузки фото с кеша
protocol FileManagerServiceProtocol {
    func getImageFromCache(url: String) -> UIImage?
    func saveImageToCache(url: String, data: Data)
}

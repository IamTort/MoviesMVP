// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// загрузка картинки
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil, networkService: NetworkServiceProtocol) {
        image = nil
        let iconUrl = "\(PurchaseEndPoint.link.rawValue)\(url)"
        networkService.fetchData(iconUrl: iconUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                let image = UIImage(data: data)
                self.image = image
            case .failure:
                break
            }
        }
    }
}

// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// загрузка картинки
extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil, networkService: NetworkServiceProtocol) {
        image = nil
        let iconUrl = "\(PurchaseEndPoint.link.rawValue)\(url)"
        networkService.loadImage(iconUrl: iconUrl) { [weak self] data in
            guard let self = self,
                  let image = UIImage(data: data) else { return }
            self.image = image
        }
    }
}

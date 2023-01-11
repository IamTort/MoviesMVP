// VideoId.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Ключ от видео
struct VideoId: Decodable {
    /// Ключ
    let key: String

    // MARK: - Initializer

    init(json: JSON) {
        key = json["key"].stringValue
    }
}

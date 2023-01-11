// VideoId.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Ключ от видео
struct VideoId {
    /// Ключ
    let key: String

    // MARK: - Initializer

    init(json: JSON) {
        key = json["key"].stringValue
    }
}

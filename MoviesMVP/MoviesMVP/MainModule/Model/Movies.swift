// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель фильма
struct Movies: Decodable {
    /// Название фильма
    let title: String
    /// Идентификатор фильма
    let id: Int
    /// Описание фильма
    let overview: String
    /// Ссылка на постер фильма
    let poster: String
    /// Рейтинг фильма
    let rate: Double
    /// Количество страниц
    let pageCount: Int?

    // MARK: - Initializer

    init(json: JSON, pageCount: Int) {
        title = json["title"].stringValue
        id = json["id"].intValue
        overview = json["overview"].stringValue
        poster = json["poster_path"].stringValue
        rate = json["vote_average"].doubleValue
        self.pageCount = pageCount
    }
}

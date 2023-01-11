// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель фильма для главного экрана
struct Movie: Decodable {
    /// Название фильма
    let title: String
    /// Идентификатор фильма
    let id: Int
    /// Описание фильма
    let overview: String
    /// Ссылка на постер фильма
    let posterPath: String
    /// Рейтинг фильма
    let rate: Double
    /// Количество страниц
    let pageCount: Int?

    // MARK: - Initializer

    init(json: JSON, pageCount: Int) {
        title = json["title"].stringValue
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        rate = json["vote_average"].doubleValue
        self.pageCount = pageCount
    }
}

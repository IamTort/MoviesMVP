// Film.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Модель фильма
struct Film: Decodable {
    /// Идентификатор фильма
    let id: Int
    /// Описание фильма
    let overview: String
    /// Ссылка на постер фильма
    let posterPath: String
    /// Девиз
    let tagline: String
    /// Название фильма
    let title: String
    /// Рейтинг фильма
    let rate: Double
    /// Дата выпуска
    let release: String
    /// Жанры
    let genres: [String]
    /// Год выпуска
    let runtime: Int

    // MARK: - Initializer

    init(json: JSON) {
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        tagline = json["tagline"].stringValue
        title = json["title"].stringValue
        rate = json["vote_average"].doubleValue
        release = json["release_date"].stringValue
        genres = json["genres"].arrayValue.map { $0["name"].stringValue }
        runtime = json["runtime"].intValue
    }
}

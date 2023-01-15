// MovieDetail.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import SwiftyJSON

/// Модель фильма
final class MovieDetail: Object {
    /// Идентификатор фильма
    @Persisted(primaryKey: true) var id: Int
    /// Описание фильма
    @Persisted var overview: String
    /// Ссылка на постер фильма
    @Persisted var posterPath: String
    /// Девиз
    @Persisted var tagline: String
    /// Название фильма
    @Persisted var title: String
    /// Рейтинг фильма
    @Persisted var rate: Double
    /// Дата выпуска
    @Persisted var releas: String
    /// Длительность фильма
    @Persisted var runtime: Int

    // MARK: - Initializer

    convenience init(json: JSON) {
        self.init()
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        tagline = json["tagline"].stringValue
        title = json["title"].stringValue
        rate = json["vote_average"].doubleValue
        releas = json["release_date"].stringValue
        runtime = json["runtime"].intValue
    }
}

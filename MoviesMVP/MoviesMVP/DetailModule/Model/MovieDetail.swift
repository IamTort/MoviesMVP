// MovieDetail.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import SwiftyJSON

/// Модель фильма
@objcMembers
final class MovieDetail: Object {
    /// Идентификатор фильма
    dynamic var id = 0
    /// Описание фильма
    dynamic var overview: String = ""
    /// Ссылка на постер фильма
    dynamic var posterPath: String = ""
    /// Девиз
    dynamic var tagline: String = ""
    /// Название фильма
    dynamic var title: String = ""
    /// Рейтинг фильма
    dynamic var rate = 0.0
    /// Дата выпуска
    dynamic var releas: String = ""
    /// Длительность фильма
    dynamic var runtime = 0

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

    override class func primaryKey() -> String? {
        "id"
    }
}

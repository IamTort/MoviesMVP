// Movie.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import SwiftyJSON

/// Модель фильма для главного экрана
@objcMembers
final class Movie: Object {
    /// Название фильма
    dynamic var title: String = ""
    /// Идентификатор фильма
    dynamic var id = 0
    /// Описание фильма
    dynamic var overview: String = ""
    /// Ссылка на постер фильма
    dynamic var posterPath: String = ""
    /// Рейтинг фильма
    dynamic var rate = 0.0
    /// Количество страниц
    dynamic var pageCount = 0
    /// Тип фильма
    dynamic var movieType = ""

    // MARK: - Initializer

    convenience init(json: JSON, pageCount: Int) {
        self.init()
        title = json["title"].stringValue
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        rate = json["vote_average"].doubleValue
        self.pageCount = pageCount
    }

    override class func primaryKey() -> String? {
        "id"
    }
}

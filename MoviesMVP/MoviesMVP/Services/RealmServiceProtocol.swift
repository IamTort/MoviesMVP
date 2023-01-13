// RealmServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Протокол реалм сервиса
protocol RealmServiceProtocol {
    func save<T: Object>(movies: [T], update: Bool)
    func loadData<T: Object>(movies: T.Type, movieType: String) -> Results<T>?
    func loadData<T: Object>(movies: T.Type, id: Int) -> MovieDetail?
}

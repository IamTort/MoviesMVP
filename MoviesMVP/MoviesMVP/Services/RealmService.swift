// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Реалм сервис
final class RealmService: RealmServiceProtocol {
    // MARK: - Public property

    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func save<T: Object>(movies: [T], update: Bool) {
        do {
            let realm = try Realm(configuration: RealmService.deleteIfMigration)
            try realm.write {
                switch update {
                case true:
                    realm.add(movies, update: .modified)
                case false:
                    realm.add(movies)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadData<T: Object>(movies: T.Type, movieType: String) -> Results<T>? {
        var movies: Results<T>?
        do {
            let realm = try Realm()
            movies = realm.objects(T.self).filter("movieType = %@", movieType)
        } catch {
            print(error.localizedDescription)
        }
        return movies
    }

    func loadData<T: Object>(movies: T.Type, id: Int) -> MovieDetail? {
        do {
            let realm = try Realm()
            return realm.object(ofType: MovieDetail.self, forPrimaryKey: id)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
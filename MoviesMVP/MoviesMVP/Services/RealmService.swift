// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Реалм сервис
final class RealmService: RealmServiceProtocol {
    // MARK: - Private Enum

    private enum Constants {
        static let typeString = "movieType = %@"
    }

    // MARK: - Public property

    private let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public Methods

    func save<T: Object>(movies: [T], update: Bool) {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
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
            movies = realm.objects(T.self).filter(Constants.typeString, movieType)
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
